<?php
/*
Plugin Name: WP Maintenance Mode
Description: Displays a maintenance message for non-logged-in users.
Version: 1.0
Author: Myo Min Soe
*/

defined('ABSPATH') or die('No script kiddies please!');

// Maintenance mode for non-logged-in users
add_action('template_redirect', function () {
    // Allow admins and editors to view the site
    if (current_user_can('edit_posts') || is_admin()) {
        return;
    }

    // Show maintenance message to all other visitors
    wp_die(
        '<h1>Maintenance Mode</h1><p>We are currently performing scheduled maintenance. Please check back soon.</p>',
        'Site Under Maintenance',
        ['response' => 503]
    );
});
