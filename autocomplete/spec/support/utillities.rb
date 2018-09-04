def fill_autocomplete(field, options = {})
  fill_in field, with:options[:with]

  page.execute_script %{ $('##{filed}').trigger('focus') }
  page.execute_script %{ $('##{field}').trigger('keydown') }

  selector = %{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:selsect]}")}
  
  expect(page).pageto have_selector('ul.ui-autocomplete li.ui-menu-item a')
  page.execute_script %{ $('#{selector}').trigger('mouseenter').click() }
end

