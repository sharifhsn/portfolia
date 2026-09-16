+++
title = "The Cost of AI-Generated Images"
date = 2025-03-28
published_at = "2025-03-28T13:00:08.066Z"
source = "LinkedIn"
source_url = "https://www.linkedin.com/feed/update/urn:li:activity:7311371515738898434/"
activity_urn = "urn:li:activity:7311371515738898434"
source_post_number = 40
tags = ["AI","Creative Work"]
+++

New AI images stun the world 🤯 but are they worth the cost? 🤔

AI images have flooded social media seemingly overnight, with the specific trend of “Ghiblization” (transforming images into the style of animation studio Studio Ghibli) becoming a popular meme. These images from ChatGPT 4o are much higher quality than previous AI images.

That’s not a coincidence. 4o uses a different method of image generation than the old model, DALL-E. DALL-E was based around diffusion.

This method models the noising of an image through a stochastic process, which has a closed-form sampling method. Then, it uses Anderson’s reverse diffusion to denoise. The score function is estimated by the UNet neural network which is trained on real images that are noised.

The denoising process starts with pure Gaussian noise, then denoises at each step. It uses the attention mechanism just like LLMs do to recognize when a patch of noise looks like something in the prompt, and denoises it to fit the desired image. After only a few dozen steps, the image is denoised.

This process has benefits and drawbacks. It’s very computationally efficient, as it renders the whole image at once in a parallelizable fashion. However, this independence between batches causes a lack of spatial reasoning, which is why diffusion images often have messed up hands or text.

4o uses autoregression instead. You can think of this as similar to what ChatGPT does, where each part of the image is generated based on previous parts of the image, left to right and top to bottom.

This takes care of the spatial reasoning element, since each part of the image develops from earlier parts. But it requires a full forward pass through the transformer stack for each new image token, attending to all previous tokens. This makes the time complexity of the process O(n^3), with no opportunity for parallelization!

This is why access to 4o’s image generation capabilities are being limited, and Sam Altman has said “our GPUs are melting”. Much hay has been made about the energy consumption of AI, and I generally think that these worries are overblown compared to other uses of energy. But autoregressive image generation seems to push that limit hard.

What do you think? Are the higher quality images worth it?
