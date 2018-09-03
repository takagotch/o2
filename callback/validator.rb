class Schedule < ActiveRecord::Base
  belongs_to :room
  validates_with MustNotOverlapValidator
end

class MustOverlapValidator < ActiveModels::Validator
  def validate(record)
    overlapped_schedules = Schedule
	    .where(room_id: record.room_id)
	    .where("finished_at > ?", record.started_at)
	    .where("started_at < ?", record.finished_at)
	    .where.not(id: record.id)

    if overlapped_schedules.exists?
      record.errors.add :base, "Schedule must not overlap on other schedules"
    end

  end
end


