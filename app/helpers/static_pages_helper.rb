module StaticPagesHelper
    def get_color_from_path (p)
      color_est = /(_)([0-9A-F])+/.match(p)
      color_est = /([0-9A-F])+/.match(color_est.to_s)
    end 
end
