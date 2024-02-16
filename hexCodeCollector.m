% Read the image
image = imread('out.bmp'); % Replace 'your_image_file.jpg' with your image file path, uses 24 bit color depth

% Get the size of the image
[height, width, ~] = size(image);

% Reshape the image to a 2D array (768x512 to 393216x3)
reshaped_image = reshape(image, height * width, 3);
%imshow(reshaped_image);
% Convert RGB values to 24-bit hexadecimal representation
hex_values = dec2hex(reshape(reshaped_image.', 1, []), 2);

% Display and save the concatenated hex values
fileID = fopen('hex_values.txt', 'w');
for i = 1:3:length(hex_values)
    concatenated_hex = strcat(hex_values(i, :), hex_values(i+1, :), hex_values(i+2, :));
    fprintf(fileID, '%s\n', concatenated_hex); % Use '\n' for line endings
end
fclose(fileID);
