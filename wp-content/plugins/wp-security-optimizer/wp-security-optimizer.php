<?php
/*
Plugin Name: WP Security Optimizer
Description: Lightweight plugin to harden and optimize your WordPress site.
Version: 1.0
Author: Your Name
*/

defined('ABSPATH') or die('No script kiddies please!');

// Disable XML-RPC
add_filter('xmlrpc_enabled', '__return_false');

// Disable REST API for non-logged-in users
add_filter('rest_authentication_errors', function ($result) {
    if (!is_user_logged_in()) {
        return new WP_Error('rest_disabled', 'REST API restricted to authenticated users.', ['status' => 401]);
    }
    return $result;
});

// Remove WordPress version from head
remove_action('wp_head', 'wp_generator');

// Disable file editing in WP admin
define('DISALLOW_FILE_EDIT', true);

// Limit post revisions
if (!defined('WP_POST_REVISIONS')) {
    define('WP_POST_REVISIONS', 5); // change number as needed
}

// Disable Emojis
remove_action('wp_head', 'print_emoji_detection_script', 7);
remove_action('wp_print_styles', 'print_emoji_styles');
remove_action('admin_print_scripts', 'print_emoji_detection_script');
remove_action('admin_print_styles', 'print_emoji_styles');
remove_filter('the_content_feed', 'wp_staticize_emoji');
remove_filter('comment_text_rss', 'wp_staticize_emoji');
remove_filter('wp_mail', 'wp_staticize_emoji_for_email');
