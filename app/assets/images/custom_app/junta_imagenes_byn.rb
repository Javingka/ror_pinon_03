require "rmagick"

path_img_est = "perspectiva/per_estanque_E1FFC6.png"
path_img_apl = "perspectiva/per_aplicacion_ABA8FF.png"
path_img_asi = "perspectiva/per_asiento_45291C.png"
path_img_man = "perspectiva/per_manilla_9C6543.png"
path_img_base = "perspectiva/per_plantilla.png"
capa_1 = Magick::Image.read( path_img_est ).first
capa_2 = Magick::Image.read( path_img_apl ).first
capa_3 = Magick::Image.read( path_img_asi ).first
capa_4 = Magick::Image.read( path_img_man ).first
capa_5 = Magick::Image.read( path_img_base ).first

capa_1.composite!(capa_2.composite!(capa_3.composite!( capa_4.composite!( capa_5,0,0, Magick::OverCompositeOp), 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ), 0,0, Magick::OverCompositeOp ) 
capa_1 = capa_1.quantize(256, Magick::GRAYColorspace).contrast(true)
capa_1.write("test1byb.jpg")

