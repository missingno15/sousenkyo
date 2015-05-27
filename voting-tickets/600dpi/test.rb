require "rtesseract"
require "rmagick"
require "pry"

WIDTH_IN_CM = 11.8
HEIGHT_IN_CM = 11.8

WIDTH_IN_INCHES = 4.7
HEIGHT_IN_INCHES = 4.7

def ascertain_shorter_side(image)
  [image.rows, image.columns].min
end
 
def ascertain_longer_side(image)
  [image.rows, image.columns].max
end

def calculate_position1(image, pos)
  dpi = (ascertain_shorter_side(image) / WIDTH_IN_INCHES).round(-2)
  px_per_cm = dpi / 2.54

  px_per_cm * pos
end

def calculate_position2(image, pos)
  px_per_cm = (ascertain_shorter_side(image) / WIDTH_IN_CM)

  px_per_cm * pos
end


FILEPATH = "crawl.png"
PATTERN  = /[a-z1-9]{8}\s[a-z1-9]{8}/

## Method1

# puts "##################################################################################################################"
# img1   = Magick::Image.read(FILEPATH)[0]
# img2   = Magick::Image.read(FILEPATH)[0]


image = Magick::Image.read("manatsu-2765×2768.jpg")[0]

area1 = {
  x: calculate_position1(image, 1.2), 
  y: calculate_position1(image, 5.5), 
  width: calculate_position1(image, 6.5), 
  height: calculate_position1(image, 0.6)
}

area2 = {
  x: calculate_position2(image, 1.2),
  y: calculate_position2(image, 5.5),
  width: calculate_position2(image, 6.5),
  height: calculate_position2(image, 0.6)
}

puts RTesseract::Mixed.new("manatsu-2765×2768.jpg", { areas: [area1] }).to_s

# image.crop!(area2[:x], area2[:y], area2[:width], area2[:height])
# image.write("sekine_yuuna.jpg")


# tesseract_image = RTesseract::Mixed.new(
#   "crawl.png",
#   {
#     areas: [
#       area2
#     ]
#   }
# )

# image1 = RTesseract::Mixed.new(
#   FILEPATH, 
#   {
#     areas: [
#       area1
#     ]
#   }
# )                              

# puts "method 1"
# puts "Here is the raw #to_s #{image1.to_s}"
# puts "Now cleaned #{image1.to_s[0][/[a-z1-9]{8}\s[a-z1-9]{8}/]}"









# puts "##################################################################################################################"
# ## Method2

# image2 = RTesseract::Mixed.new(
#   FILEPATH,
#   {
#     areas: [
#       area2
#     ]
#   }
# )

# puts "method 2"
# puts "Here is the raw #to_s #{image2.to_s}"
# puts "Now cleaned #{image2.to_s[0][/[a-z1-9]{8}\s[a-z1-9]{8}/]}"



# puts "##################################################################################################################"
