
// Author    Martin Dubois
// Copyright (C) 2025 Martin Dubois
// Product   Models3D
// File      Printers/SpoolLock.scad

use <C:\_VC\Base3D\Cylinder.scad>
use <C:\_VC\Base3D\Metric\M3.scad>

Left();
Right();

module Left()
{
    difference()
    {
        CABLE_R  = 3.5;
        PLANE_X2 = 5;
        SIZE_X   = 41;
        SLOT_W1  = SLOT_W0 + 2 * SPACE;

        Base( 0, SIZE_X );

        End( - EPS );

        Holes( SIZE_X - 6 );

        Spring( SPRING_R2, 5, SIZE_X - 5 + EPS );

        // Cable
        translate( [ PLANE_X2 + CABLE_R, - SPRING_R3 - 3 - EPS, SPRING_CZ ] )
            Cylinder_Y( 2 * EPS + 2 * SPRING_R3 + 6, CABLE_R, 32 );

        // Fingers
        for ( y = [ - 16.2, 16.2 ] )
        {
            Finger( 12, y );
        }

        // Slot
        translate( [ 0, - SLOT_W1 / 2, 0 ] )
        {
            translate( [ SIZE_X - SLOT_L, 0, - EPS ] )
                cube( [ 25 + EPS, SLOT_W1, EPS + SPRING_CZ ] );

            translate( [ PLANE_X2, 0, SPRING_CZ ] )
                cube( [ SIZE_X - 7, SLOT_W1, SPRING_R3 + EPS ] );
        }
    }
}

module Right()
{
    color( "blue" )
    {
        difference()
        {
            BASE_X   = 23;
            PLANE_X2 = 42;

            PLANE_X1 = PLANE_X2 - SLOT_L;

            union()
            {
                Base( PLANE_X2, BASE_X );

                Spring( SPRING_R1, PLANE_X1, SLOT_L );

                translate( [ PLANE_X1, - SLOT_W0 / 2, 0 ] )
                    cube( [ SLOT_L, SLOT_W0, SPRING_CZ ] );

                translate( [ PLANE_X1 - 2, 0, SPRING_CZ ] )
                {
                    rotate( [ 0, 90, 0 ] )
                        cylinder( 2, SPRING_R0 - 1, SPRING_R0, $fn = 16 );
                }
            }

            End( PLANE_X2 + BASE_X - 3 );

            Finger( PLANE_X2 + 10, 0 );

            Holes( PLANE_X2 + 6 );

            translate( [ PLANE_X1 + 3, 0, 2 ] )
                M3_Thread_Z( SPRING_CZ + 2 );

            translate( [ PLANE_X1 + 3, 0, SPRING_CZ + SPRING_R1 - 0.5 ] )
                M3_Head_Z( 0.5 + EPS );
        }
    }
}

module Base( aX, aLength )
{
    translate( [ aX, - SIZE_Y / 2, 0 ] )
        cube( [ aLength, SIZE_Y, BASE_Z ] );

    Spring( SPRING_R3, aX, aLength );
}

module End( aX )
{
    SIZE_R = 99;

    translate( [ aX, 0, 2 + SIZE_R ] )
        Cylinder_X( EPS + 3, SIZE_R, 128 );
}

module Finger( aX, aY )
{
    translate( [ aX, aY, - EPS ] )
    {
        scale( [ 0.7, 1, 1 ] )
            Cylinder_Z( 2 * EPS + SIZE_Z, 10, 32 );
    }
}

module Holes( aX )
{
    for ( y = [ - 20, 20 ] )
    {
        translate( [ aX, y, - EPS ] )
            Cylinder_Z( 2 * EPS + BASE_Z, 3, 16 );
    }
}

module Spring( aR, aX, aLength )
{
    translate( [ aX, 0, SPRING_CZ ] )
        Cylinder_X( aLength, aR, 32 );
}

EPS = 0.1;

BASE_Z = 6;

SIZE_Y = 60;

SLOT_L  = 23;
SLOT_W0 =  6;

SPACE = 0.12;

SPRING_R1 = 4;


SPRING_CZ = BASE_Z + SPRING_R1 - 0.7;
SPRING_R0 = SPRING_R1 - 1;
SPRING_R2 = SPRING_R1 + SPACE;
SPRING_R3 = SPRING_R2 + 2.08;


SIZE_Z = SPRING_CZ + SPRING_R3;
