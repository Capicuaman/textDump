{
  "prompt": "A hyper-realistic product photo of a single branded bag standing in the middle of a lush Yucatán jungle clearing, with dense tropical trees, vines, and deep green foliage in the background, warm natural daylight. Vertical 9:16 format, the bag is in the exact center of the frame, captured with correct perspective as if physically placed on the ground, product fills about 20–30% of the frame. The logo on the bag is always fully visible, sharp, and easily readable. Background slightly blurred with a shallow depth of field so the bag pops from the scene, rich but not distracting colors. Leave 30–35% clean negative space at the top of the image for text overlays, no objects or strong contrasts in that area. Photorealistic, high resolution, soft natural shadows, studio-quality product lighting.",
  "negative_prompt": "extra objects, cluttered background, cropped logo, distorted text, incorrect aspect ratio, low resolution, illustration, cartoon, painting, over-saturated colors, harsh shadows, busy elements in top area of the frame",
  "width": 1024,
  "height": 1820,
  "aspect_ratio": "9:16",
  "num_images": 4,
  "cfg_scale": 7.5,
  "steps": 30,
  "seed": null,
  "sampler": "DPM++ 2M Karras",
  "style": "photorealistic product photography",
  "camera": {
    "lens": "50mm",
    "shot_type": "mid shot",
    "focus": "sharp focus on bag, shallow depth of field"
  },
  "lighting": {
    "type": "natural daylight",
    "quality": "soft, diffused",
    "shadows": "soft natural shadows"
  },
  "composition": {
    "framing": "bag centered in frame",
    "product_size_in_frame": "20-30%",
    "negative_space_top": "30-35% for text overlays",
    "background_blur": "medium, keeps jungle recognizable but not distracting"
  },
  "environment": {
    "location": "Yucatán jungle clearing",
    "elements": [
      "dense tropical trees",
      "vines",
      "deep green foliage"
    ],
    "mood": "fresh, natural, vibrant but not overly saturated"
  }
}


{
"model": "gemini-2.5-flash-image",
"contents": [
{
"role": "user",
"parts": [
{
"text": {
"subject": "A single branded bag standing in the middle of a misty forest clearing.",
"environment": {
"location": "Forest clearing",
"surroundings": [
"Tall trees",
"Soft ground vegetation",
"Layered depth in the background"
],
"lighting_mood": "Cool, soft daylight filtering through the canopy"
},
"composition": {
"format": "Vertical 9:16",
"framing": "Bag in the exact center of the frame",
"perspective": "Correct perspective, as if physically placed on the forest floor",
"product_size_in_frame": "Product fills about 20–30% of the frame",
"negative_space": "Leave 30–35% clean negative space at the top of the image for text overlays, no objects or strong contrasts in that area"
},
"product_details": {
"logo_visibility": "Logo on the bag is always fully visible, sharp, and easily readable",
"focus": "Bag in sharp focus with a shallow depth of field"
},
"background": {
"blur": "Background slightly blurred so the bag pops from the scene",
"colors": "Rich but not distracting natural greens and browns"
},
"style": {
"realism": "Photorealistic",
"resolution": "High resolution",
"lighting": "Soft natural shadows, studio-quality product lighting that still feels integrated into the forest environment"
}
}
}
]
}
],
"config": {
"response_modalities": ["IMAGE"],
"image_config": {
"aspect_ratio": "9:16"
}
}
}