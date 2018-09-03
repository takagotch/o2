step 'Search form micropost_content @ar input auto complete show select' do
  fill_autocomplete 'micropost_content', with: '@ar'
end

step 'Post Button click' do
  click_button 'Post'
end



