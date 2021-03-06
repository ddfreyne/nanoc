require 'helper'

class Nanoc::Filters::HandlebarsTest < Nanoc::TestCase
  def test_filter
    skip_v8_on_ruby24

    if_have 'handlebars' do
      # Create data
      item = Nanoc::Int::Item.new(
        'content',
        { title: 'Max Payne', protagonist: 'Max Payne', location: 'here' },
        '/games/max-payne/',
      )
      layout = Nanoc::Int::Layout.new(
        'layout content',
        { name: 'Max Payne' },
        '/default/',
      )
      config = { animals: 'cats and dogs' }

      # Create filter
      assigns = {
        item: item,
        layout: layout,
        config: config,
        content: 'No Payne No Gayne',
      }
      filter = ::Nanoc::Filters::Handlebars.new(assigns)

      # Run filter
      result = filter.setup_and_run('{{protagonist}} says: {{yield}}.')
      assert_equal('Max Payne says: No Payne No Gayne.', result)
      result = filter.setup_and_run('We can’t stop {{item.location}}! This is the {{layout.name}} layout!')
      assert_equal('We can’t stop here! This is the Max Payne layout!', result)
      result = filter.setup_and_run('It’s raining {{config.animals}} here!')
      assert_equal('It’s raining cats and dogs here!', result)
    end
  end

  def test_filter_without_layout
    skip_v8_on_ruby24

    if_have 'handlebars' do
      # Create data
      item = Nanoc::Int::Item.new(
        'content',
        { title: 'Max Payne', protagonist: 'Max Payne', location: 'here' },
        '/games/max-payne/',
      )

      # Create filter
      assigns = {
        item: item,
        content: 'No Payne No Gayne',
      }
      filter = ::Nanoc::Filters::Handlebars.new(assigns)

      # Run filter
      result = filter.setup_and_run('{{protagonist}} says: {{yield}}.')
      assert_equal('Max Payne says: No Payne No Gayne.', result)
    end
  end
end
