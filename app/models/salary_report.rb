class SalaryReport < ActiveRecord::Base

  WEEKS_PER_YEAR = 52.2

  belongs_to :user
  before_create :setup

  # Setup a report using the current settings.
  def setup
    self.week_hours = Setting.plugin_salary_reports[:week_hours]
    self.weeks_of_per_year = Setting.plugin_salary_reports[:weeks_of_per_year] 
    self.days_of_per_year = Setting.plugin_salary_reports[:days_of_per_year] 
    self.start_date = self.user.custom_field_values.select{|v| v.custom_field.name == "Employment Date"}.first.value
    self.workload = self.user.custom_field_values.select{|v| v.custom_field.name == "Workload"}.first.value.to_f * 0.01
    self.salary = Setting.plugin_salary_reports[:salary].to_f * self.workload
    self.ahv_rate = Setting.plugin_salary_reports[:ahv_rate].to_f * 0.01
    self.alv_rate = Setting.plugin_salary_reports[:alv_rate].to_f * 0.01
    self.pension_pool_rate = Setting.plugin_salary_reports[:pension_pool_rate].to_f * 0.01
    self.nbu_rate = Setting.plugin_salary_reports[:nbu_rate].to_f * 0.01
    self.nbu_rate_frac = Setting.plugin_salary_reports[:nbu_rate_frac].to_f
  end

  # Fraction of year considered in the report
  def frac(date_from)
    delay = (self.date_to - date_from) / 24 / 3600
    delay / 365 
  end

  # Calculate the total number of working hours per year.
  def working_hours_per_year
    WEEKS_PER_YEAR * self.week_hours
  end

  # Returns the date, when person started working or beginning of year.
  def employment_date
    if self.start_date.nil? or self.start_date < Date.today.at_beginning_of_year
      return Date.today.at_beginning_of_year.to_time
    else
      return self.start_date
    end
  end
  
  # Hours worked during period
  def working_hours(date_from = self.date_from)
    TimeEntry.where(user: self.user, spent_on: date_from..self.date_to).sum{|t| t.hours }
  end
  
  # Hours worked during period ignoring holidays and days of
  def working_hours_ignoring_holidays(date_from = self.date_from)
    TimeEntry.where(user: self.user, spent_on: date_from..self.date_to).sum{|t| !["Ferien", "Feiertag"].include?(t.activity.name)  ? t.hours : 0}
  end

  # AHV rate employee
  def ahv_rate_employee
    self.ahv_rate / 2
  end
  
  # AHV contributions
  def ahv_contribution  
    self.salary_net * self.ahv_rate_employee
  end

  # AHV rate employee
  def alv_rate_employee
    self.alv_rate / 2
  end
  
  # ALV contributions
  def alv_contribution  
    self.salary_net * self.alv_rate_employee
  end

  # Pension pool rate employee
  def pension_pool_rate_employee
    self.pension_pool_rate
  end
  
  # Pension pool contributions
  def pension_pool_contribution  
    self.salary_net * self.pension_pool_rate_employee
  end

  # Pension pool rate employee
  def nbu_rate_employee
    self.nbu_rate * self.nbu_rate_frac
  end
  
  # Pension pool contributions
  def nbu_contribution  
    self.salary_net * self.nbu_rate_employee
  end

  # Summarize all contributions
  def total_contributions
    self.ahv_contribution + self.alv_contribution + self.nbu_contribution + self.pension_pool_contribution
  end

  # Net salary 
  def salary_net
    self.salary
  end

  # Total salary (Gross)
  def salary_gross
    self.salary + self.total_contributions
  end

  def calc_overtime_ignoring_holidays(date_from = self.date_from)
    goalTot =  self.working_hours_per_year - (self.weeks_of_per_year * self.week_hours + self.days_of_per_year * self.week_hours / 5)
    goal = self.workload * goalTot * frac(date_from)
    self.working_hours_ignoring_holidays(date_from) - goal
  end
  
  def calc_overtime_considering_holidays(date_from = self.date_from)
    goalTot =  self.working_hours_per_year
    goal = self.workload * goalTot * frac(date_from)
    self.working_hours(date_from) - goal
  end
  
  def calc_holidays_taken(date_from = self.date_from)
    TimeEntry.where(user: self.user, spent_on: date_from..self.date_to).sum{|t| "Ferien" == t.activity.name ? t.hours : 0}
  end

  def calc_percentage_holidays_taken
    100 * (self.calc_holidays_taken / (self.weeks_of_per_year * self.week_hours * self.workload))
  end

end
