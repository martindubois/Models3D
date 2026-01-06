
// Author    Martin Dubois
// Copyright (C) 2025 Martin Dubois
// Product   Models3D
// File      Computer/OpenCase.scad

difference()
{
    union()
    {
        cylinder( ZIP_Z, BAT_R, BAT_R );

        translate( [ 1, 0, ZIP_Z ] )
        {
            scale( [ 1.5, 1, 1 ] )
                cylinder( ZIP_SZ, 5, 5 );
        }

        translate( [ 0, 0, ZIP_Z + ZIP_SZ ] )
            cylinder( BAT_SZ - ZIP_SZ - ZIP_Z, BAT_R, BAT_R );
    }

    translate( [ - BAT_R - EPS, - WIRE_R, - EPS ] )
        cube( [ EPS + WIRE_D, WIRE_D, 2 * EPS + BAT_SZ ] );

    translate( [ - 5, - BAT_R - EPS, 5 ] )
        cube( [ 10, 2 * EPS + BAT_D, 10 ] );

    for ( y = [ - 10, 7 ] )
    {
        translate( [ 5 - EPS, y, 5 ] )
            cube( [ EPS + 4, 3, 10 ] );
    }
}

BAT_R  = 11;
BAT_SZ = 47;

EPS = 0.1;

WIRE_R = 3;

ZIP_SZ = 10;
ZIP_Z  = 20;


BAT_D = 2 * BAT_R;

WIRE_D = 2 * WIRE_R;