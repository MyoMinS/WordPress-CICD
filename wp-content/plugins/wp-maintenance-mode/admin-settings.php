<?php
// Add settings page to Admin > Settings
add_action('admin_menu', function () {
    add_options_page(
        'Maintenance Mode',
        'Maintenance Mode',
        'manage_options',
        'wpm-maintenance',
        'wpm_render_settings_page'
    );
});

// Register settings
add_action('admin_init', function () {
    register_setting('wpm_settings_group', 'wpm_maintenance_enabled');
    register_setting('wpm_settings_group', 'wpm_maintenance_message');
});

function wpm_render_settings_page() {
    ?>
    <div class="wrap">
        <h1>Maintenance Mode Settings</h1>
        <form method="post" action="options.php">
            <?php settings_fields('wpm_settings_group'); ?>
            <table class="form-table">
                <tr valign="top">
                    <th scope="row">Enable Maintenance Mode</th>
                    <td>
                        <input type="checkbox" name="wpm_maintenance_enabled" value="1" <?php checked(1, get_option('wpm_maintenance_enabled', 0)); ?> />
                    </td>
                </tr>
                <tr valign="top">
                    <th scope="row">Custom Message</th>
                    <td>
                        <textarea name="wpm_maintenance_message" rows="4" cols="50"><?php echo esc_textarea(get_option('wpm_maintenance_message', 'We are doing maintenance. Please come back soon.')); ?></textarea>
                    </td>
                </tr>
            </table>
            <?php submit_button(); ?>
        </form>
    </div>
    <?php
}
