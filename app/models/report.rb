class Report < ActiveRecord::Base

  belongs_to :user
  def calc(user)
    # Settings
    weekHours = 40
    weeksOf = 8
    workingHoursPerYear = 2088
    feastDays = 10

    startDate = user[:date] ? user[:date] : Date.today.at_beginning_of_year
    
    delay = Date.today - startDate
    frac = delay / 365

    # Info
    redmineUser = User.find(user[:id])
    puts "Username: #{redmineUser.login}"

    # Ignoring holidays
    goalTot =  workingHoursPerYear - (weeksOf * weekHours + feastDays * weekHours / 5)
    goal = user[:pensum] * goalTot * frac
    spent = TimeEntry.where(user: redmineUser).sum{|t| (!["Ferien", "Feiertag"].include?(t.activity.name) and  t.spent_on > startDate)  ? t.hours : 0}
    reached =  spent - goal
    puts "#{reached}h : Overtime (ignoring holidays)"
    
    # Considering holidays
    goalTot =  workingHoursPerYear
    goal = user[:pensum] * goalTot * frac
    spent = TimeEntry.where(user: redmineUser).sum{|t| (t.spent_on > startDate)  ? t.hours : 0}
    reached =  spent - goal
    puts "#{reached}h : Overtime (considering holidays)"
    
    holidays = TimeEntry.where(user: redmineUser).sum{|t| (["Ferien"].include?(t.activity.name) and  t.spent_on > startDate)  ? t.hours : 0}
    puts "#{holidays}h : Holidays taken"
    percentageHolidays = 100 * (holidays / (weeksOf * weekHours * user[:pensum]))
    puts "#{percentageHolidays}% : Percentage Holidays taken"
  end
end
