entity_status
=============

Ruby Gem for adding status helper methods to an activerecord model.

### Installlation

		gem 'entity_status', git: 'git@github.com:jbueler/entity_status.git'

Bundle install

This gem will modify a string column in your database and is configurable to which column you want to use.
To change the column used for the status call `entity_status <#column_name#>`

Include module in your Model, this will get you default statuses of `pending`, `open`, `closed`

		class Post < ActiveRecord::Base
		  include EntityStatus # the default column EntityStatus will look for is `status`
		end

You can configure custom statuses per model by calling entity_status in your Model:

		class Post < ActiveRecord::Base
		  include EntityStatus
			entity_status :status, [:incomplete,:complete]
		end

You can configure multiple status columns per model by calling entity_status multiple times in your Model:

		class Post < ActiveRecord::Base
		  include EntityStatus
			entity_status :status, [:incomplete,:complete]
			entity_status :moderation_status, [:pending,:approved,:rejected]
		end

### Using EntityStatus
You can now start using the helper methods:

		Post.incomplete #=> will return all Post entities with status == 'incomplete'
		p = Post.incomplete.first
		p.complete? #=> false
		p.complete #=> returns p with p.status == 'complete'
		p.complete? #=> true
		
		// USING THE SECOND ENTITY STATUS
		p.approved #=> returns p with p.moderation_status == 'approved'		
		if(p.approved? && p.complete?)
			// THIS IS APPROVED AND COMPLETED
		elsif(!p.approved?)
			// THIS IS NOT APPROVED
		end
		

