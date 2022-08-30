# Redmine Reports

This software is beta. There in absolutely no warranty. Use at own risk...

## Setup
* Install the gems.
* Run the migrations. (`rails redmine:plugins NAME=reports RAILS_ENV=production`)
* Create the following "Custom Fields" for "Users".
  * `Employment Date` (Date)
  * `Workload` (Integer between 0 and 100)
* Configure the plugins settings.