
// Author    Martin Dubois
// Copyright (C) 2025 Martin Dubois
// Product   Models3D
// File      Computer/MonitorLeg.scad

difference()
{
    union()
    {
        cylinder( 2, SIZE_R2, SIZE_R2, $fn = 32 );

        translate( [ 0, 0, 2 ] )
            cylinder( 10, SIZE_R2, SIZE_R1, $fn = 32 );

        translate( [ 0, 0, 12 ] )
            cylinder( HIGHT - 2 - 10 + 10, SIZE_R1, SIZE_R1, $fn = 32 );
    }

    translate( [ - 15 - EPS, - 6, HIGHT ] )
        cube( [ 2 * EPS + SIZE_D1, SIZE_D1 - 6 + EPS, 10 + EPS ] );

    translate( [ 0, 0, - EPS ] )
        cylinder( 2 * EPS + SIZE_Z, SIZE_R0, SIZE_R0, $fn = 32 );
}

EPS = 0.1;

HIGHT = 64;

SIZE_R0 =  7;
SIZE_R1 = 15;
SIZE_R2 = 25;


SIZE_D1 = 2 * SIZE_R1;
SIZE_Z  = HIGHT + 10;
