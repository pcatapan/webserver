<?php

// -- query function --------------#
function query_var($query_string) {
    if ($query_string) {
        $query_params = explode('&', $query_string);
        $params_dict = array();
        foreach ($query_params as $param) {
            if (strpos($param, "=") !== false) {
                list($name, $value) = explode('=', $param, 2);
                $params_dict[$name] = $value;
            }
        }
        return $params_dict;
    }
    return null;
}
//* -- end query function  --------#

//  -- template function ----------#
function get_page($params_dict) {
    if ($params_dict) {
        $title = array_key_exists('title', $params_dict) ? $params_dict['title'] : 'ff';
        $heading = array_key_exists('heading', $params_dict) ? $params_dict['heading'] : 'ff';
        $message = array_key_exists('message', $params_dict) ? $params_dict['message'] : 'ff';
    }

    if (getenv('VALID_COOKIE') == "NO") {
        $template = file_get_contents('./public/assets/no_cookie.html');
        $html = $template;
    } elseif ($params_dict && count($params_dict) >= 3) {
        $template = file_get_contents('./public/assets/template.html');
        $html = str_replace(array('{title}', '{heading}', '{message}'), array($title, $heading, $message), $template);
    } else {
        $template = file_get_contents('./public/assets/post_template.html');
        $html = $template;
    }

    return $html;
}
//* -- end template function ------#

// ---- start env ---------------#
$query_string = getenv('QUERY_STRING') ?: '';
$body_string = getenv('REQUEST_BODY') ?: '';
$request_method = getenv('REQUEST_METHOD');
//* --- end env -----------------#

$query_data = query_var($query_string);
$body_data = query_var($body_string);

if ($query_data) {
    echo get_page($query_data);
} else {
    echo get_page($body_data);
}

?>