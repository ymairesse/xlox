<?php

// d'après https://www.allphptricks.com/create-a-simple-captcha-script-using-php/

session_start();

require_once '../config.inc.php';

require_once INSTALL_DIR.'/inc/classes/class.Application.php';
$Application = new Application();

$nbchar = isset($_GET['nbchar']) ? $_GET['nbchar'] : 5;

$appli = 'oxxl';
$captcha_code = $Application->getLettersCaptcha($nbchar);

// enregistrement dans la session
$_SESSION[$appli]['captcha'] = $captcha_code;

//You can customize your captcha settings here
$captcha_image_height = 50;
$captcha_image_width = 130;
$random_captcha_dots = 40;
$random_captcha_lines = 15;
$captcha_text_color = "0xff33ff";
$captcha_noise_color = "0x552255";

$captcha_font_size = $captcha_image_height * 0.65;
$captcha_image = @imagecreate(
     $captcha_image_width,
     $captcha_image_height
     );

/* setting the background, text and noise colours here */
$background_color = imagecolorallocate(
    $captcha_image,
    255,
    255,
    255
    );

$array_text_color = hextorgb($captcha_text_color);
$captcha_text_color = imagecolorallocate(
    $captcha_image,
    $array_text_color['red'],
    $array_text_color['green'],
    $array_text_color['blue']
    );

$array_noise_color = hextorgb($captcha_noise_color);
$image_noise_color = imagecolorallocate(
    $captcha_image,
    $array_noise_color['red'],
    $array_noise_color['green'],
    $array_noise_color['blue']
    );

/* Generate random dots in background of the captcha image */
for( $count=0; $count < $random_captcha_dots; $count++ ) {
    imagefilledellipse(
         $captcha_image,
         mt_rand(0,$captcha_image_width),
         mt_rand(0,$captcha_image_height),
         2,
         5,
         $image_noise_color
     );
}

/* Generate random lines in background of the captcha image */
for( $count=0; $count < $random_captcha_lines; $count++ ) {
    imageline(
     $captcha_image,
         mt_rand(0,$captcha_image_width),
         mt_rand(0,$captcha_image_height),
         mt_rand(0,$captcha_image_width),
         mt_rand(0,$captcha_image_height),
         $image_noise_color
     );
}

/* Create a text box and add 6 captcha letters code in it */
$captcha_font = '../font/monofont.ttf';

$text_box = imagettfbbox(
    $captcha_font_size,
    0,
    $captcha_font,
    $captcha_code
    );

$x = ($captcha_image_width - $text_box[4])/2;
$y = ($captcha_image_height - $text_box[5])/2;

imagettftext(
    $captcha_image,
    $captcha_font_size,
    0,
    $x,
    $y,
    $captcha_text_color,
    $captcha_font,
    $captcha_code
    );


/* Show captcha image in the html page */
// defining the image type to be shown in browser widow
header('Content-Type: image/jpeg');
imagejpeg($captcha_image); //showing the image
imagedestroy($captcha_image); //destroying the image instance


function hextorgb ($hexstring) {
    $integar = hexdec($hexstring);
    return array(
            "red" => 0xFF & ($integar >> 0x10),
            "green" => 0xFF & ($integar >> 0x8),
            "blue" => 0xFF & $integar
            );
    }
