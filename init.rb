Redmine::Plugin.register :reports do
  name 'Reports plugin'
  author 'Aeneas Meier'
  description 'This plugin creates monthly reports for all employes.'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://rgb.retikolo.xyz'


  menu :top_menu, :reports, { controller: 'reports', action: 'index' }, caption: 'Reports'
  settings default: {
    week_hours: 40, 
    weeks_of_per_year: 6, 
    days_of_per_year: 10,
    salary: 0,
    ahv_rate: 10.6,
    alv_rate: 2.2,
    pension_pool_rate: 0,
    nbu_rate: 0,
    nbu_rate_frac: 0.5
  }, partial: 'settings/reports_settings'
end
