function display_random_bw_image(rows, cols)
    % Display a black-and-white image generated from a random binary matrix.
    if nargin < 1
        rows = 256;
    end
    if nargin < 2
        cols = 256;
    end

    validateattributes(rows, {'numeric'}, {'scalar', 'integer', 'positive', 'finite'});
    validateattributes(cols, {'numeric'}, {'scalar', 'integer', 'positive', 'finite'});

    random_matrix = randi([0, 1], rows, cols);

    figure;
    imagesc(random_matrix);
    colormap(gray(2));
    caxis([0, 1]);
    axis image;
    axis off;
    title('Random Black-and-White Image');
end
