prawn_document do |pdf|

  pdf.font_size(16) { 
    pdf.text "Lohnabrechnung", 
    character_spacing: 0.5 
  }
  pdf.move_down 40
  
  pdf.font_size(10) { 
    pdf.text "Genoss*innenschaft RGB Retikolo, Kleinhüningerstrasse 161, 4057 Basel" , 
    character_spacing: 0.5 
  }
  pdf.move_down 10
  pdf.font_size(12) { 
    pdf.text "#{I18n.l @report.date_from, format: "%d.%m.%y"} - #{I18n.l @report.date_to, format: "%d.%m.%y"}" , 
    character_spacing: 0.5 
  }
  pdf.font_size(12) { 
    pdf.text @report.user.to_s, 
    character_spacing: 0.5 
  }
  
  pdf.move_down 40
  
  # Salary table
  table = [["Position", "Satz %", "CHF"]]
  
  table += [["Nettolohn", "", "%0.2f" % @report.salary_net]]
  table += [["AHV / IV / EO", @report.ahv_rate_employee * 100, "%0.2f" % @report.ahv_contribution]]
  table += [["ALV", @report.alv_rate_employee * 100, "%0.2f" % @report.alv_contribution]]
  table += [["Pensionskasse", @report.pension_pool_rate_employee * 100, "%0.2f" % @report.pension_pool_contribution]]
  table += [["NBU", @report.nbu_rate_employee * 100, "%0.2f" % @report.nbu_contribution]]
  table += [["TOTAL Beiträge", "", "%0.2f" % @report.total_contributions]]
  table += [["Bruttolohn", "", "%0.2f" % @report.salary_gross]]
  
  pdf.font_size(10) { 
    pdf.table(table) do
      cells.padding =  1
      cells.borders = []
      columns(0).width = 400
      columns(1).width = 60
      row(0).borders = [:bottom]
      row(0).border_width = 1
      row(0).font_style = :bold

      row(6).borders = [:bottom, :top]
      row(6).border_width = 1
      row(7).font_style = :bold
    end
  }

  pdf.move_down 40

  # Worktime table
  table = [["Position", "Zeit h"]]
  
  table += [["Arbeitszeit", "%0.2f" % @report.working_hours]]
  table += [["Ferien", "%0.2f" % @report.calc_holidays_taken ]]
  table += [["Überstunden", "%0.2f" % @report.calc_overtime_ignoring_holidays]]

  pdf.font_size(10) { 
    pdf.table(table) do
      cells.padding =  1
      cells.borders = []
      columns(0).width = 460
      row(0).borders = [:bottom]
      row(0).border_width = 1
      row(0).font_style = :bold

    end
  }
end