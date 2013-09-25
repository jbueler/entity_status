entity_status
=============

Ruby Gem for adding status helper methods to an activerecord model.

### Installlation

		gem 'entity_status', git: 'git@github.com:jbueler/entity_status.git'

Bundle install

**Your model should have a string attribute named `status`**

Include module in your Model, this will get you default statuses of `pending`, `open`, `closed`

		class Post < ActiveRecord::Base
		  include EntityStatus
		end

You can configure custom statuses per model by calling entity_status in your Model:

		class Post < ActiveRecord::Base
		  include EntityStatus
			entity_status :incomplete,:complete
		end

### Using EntityStatus
You can now start using the helper methods:

		Post.incomplete #=> will return all Post entities with status == 'incomplete'
		p = Post.incomplete.first
		p.complete? #=> false
		p.complete #=> 'complete'
		p.complete? #=> true


