better-states-select
====================

Originally from http://svn.techno-weenie.net/projects/plugins/us_states/
then was at https://github.com/thincloud/us-state-select-plugin.

No one seems to be maintaining this (ignoring my pull requests) so I've 
improved the library (added support for Canada) and now named it 
better-states-select.

To select "priority" states that show up at the top of the list, call
like so:

    <%= state_select 'child', 'state', :priority => %w(TX CA) %> 

## Changing Option/Value with :show

The default...

    <%= state_select 'child', 'state'%> 

...will yield this:

    <option value="AK">Alaska</option>
    
- - -

Or you can change it up...

    <%= state_select 'child', 'state', :show => :full %> 

...and get this.

    <option value="Alaska">Alaska</option>

- - -

Options are:

* :full = <option value="Alaska">Alaska</option>
* :full_abb = <option value="AK">Alaska</option>
* :abbreviations = <option value="AK">AK</option>
* :abb_full_abb = <option value="AK">AK - Alaska</option>
* :country - defaults to US states, but if you pass "Canada" you'll get Canadian provinces

You can also pass a proc to show:

    <%= state_select 'child', 'state', :show => Proc.new {|state| [state.first, state.first]} %> 
    
The array you are iterating over looks like this:

    [["Alaska", "AK"], ["Alabama","AL"], ...]