<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '$WP_DB' );

/** MySQL database username */
define( 'DB_USER', '$MYSQL_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', '$MYSQL_PASS' );

/** MySQL hostname */
define( 'DB_HOST', '$MYSQL_SERV' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'M8^jfh{b*DyE5SRzNKePI#;V4$Bi2-XT,SleI[9vw|woR$O9iezf1`ves?9;AVL3' );
define( 'SECURE_AUTH_KEY',  'K>0Y:dtX$U`b<xGM|P:mrkWyr2g{XL;y(6P3nY6Y=;-W[18),zzVtE!3mDFfyvJM' );
define( 'LOGGED_IN_KEY',    'H5[4BJrH[H_!@_|I.d@_Y[ajXp|fmASHvhtlIADE-{.K#p3!9}-|Qq30kIZD(%L/' );
define( 'NONCE_KEY',        '$gb+Nj8KE2 1zO4o(rAC]+s{*m#{}MK|2a;UzH;SHyxT T_O/QTyU?)--C6:OW.X' );
define( 'AUTH_SALT',        '5TjmF0+A~JexJ`8ev%&RS(OYTU,%EU)6;{ikXd3~gu)Z LIi+IjZdiyQ>pe)UHvZ' );
define( 'SECURE_AUTH_SALT', 'PhWz=R[PpCsSps=y{h=ww+Ptrt(S@~}C.IF(TmsL@N&dVeL$5<WxAZ@^#:[%h*6z' );
define( 'LOGGED_IN_SALT',   '%N~u-L=Z*zb~})2{RR6Fx#V;_kLyHg.T5kl7)R)-ZBw=l)UwHpIf-0LilhT1YJi{' );
define( 'NONCE_SALT',       'oU[Q#lc}t3E,Nl:8ml+3UR $#C;|kQnpf8*jBqo[?@c_2jQ;3Va^lmB}r(4(f?D~' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

define( ‘CONCATENATE_SCRIPTS’, false );
define( ‘SCRIPT_DEBUG’, true );

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
