class AdminController < ApplicationController

  def deleted_points
    if params[:retro_id].present?
      retro = Retro.find_by_id_and_name(params[:retro_id],params[:retro_name], :include => :sections)
      @points = []
      retro.sections.each do |s|
        @points.concat(Point::Deleted.find(:all, :conditions => ["section_id=?",s.id]))
      end
    end
  end

  def restore_deleted
    point = Point::Deleted.find(params[:point_id])
	  point.undestroy!
	  redirect_to :action => :deleted_points
  end
  
end
