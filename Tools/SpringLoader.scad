
// Author    Martin Dubois
// Copyright (C) 2025 Martin Dubois
// Product   Models3D
// File      Tools/SpringLoader.scad

use <C:\_VC\Base3D\Cylinder.scad>
use <C:\_VC\Base3D\Metric\M3.scad>

// Left();
Right();

// for ( x = [ 2, SIZE_X - ROD_D1 - BEARING_SX, 50 + ROD_D1 ] ) Bearing( x );

module Left()
{
    difference()
    {
        PLANE_X_0 = SIZE_X - ROD_D1; // Front of the second bearing

        Base();

        Bearing_Hole( - EPS, EPS + 2 + BEARING_SX );
        Bearing_Hole( PLANE_X_0 - BEARING_SX, BEARING_SX + ROD_D1 + EPS );

        Screw_Hole( 2 + BEARING_SX / 2 );
        Screw_Hole( PLANE_X_0 - BEARING_SX / 2 );

        Slot_Cube( SIZE_X - ROD_R1 );
        Slot_Cylinder( SIZE_X - ROD_R1 );
    }
}

module Right()
{
    color( "blue" )
    {
        translate( [ 50, 0, 0 ] )
        {
            difference()
            {
                HEX_R1 = 6.6;
                HEX_SX = 5;
                PLANE_X_0 = SIZE_X - 10; // Back of the hex

                Base();

                Bearing_Hole( - EPS, EPS + ROD_D1 + BEARING_SX );

                Screw_Hole( ROD_D1 + BEARING_SX / 2 );
                Screw_Hole( PLANE_X_0 + HEX_SX / 2 );

                Slot_Cube( - EPS );
                Slot_Cylinder( ROD_R1 );

                translate( [ PLANE_X_0, 0, 0 ] )
                {
                    rotate( [ 30, 0, 0 ] )
                        Cylinder_X( 10 + EPS, HEX_R1, 6 );
                }
            }
        }
    }
}

module Base()
{
    difference()
    {
        union()
        {
            Cylinder_X( SIZE_X, SIZE_R, 32 );

            translate( [ 0, - TOP_SY / 2, 0 ] )
                cube( [ SIZE_X, TOP_SY, PLANE_Z_0 + ROD_R1 + 5 ] );
        }

        translate( [ - EPS, 0, 0 ] )
            Cylinder_X( 2 * EPS + SIZE_X, ROD_R1, 32 );
    }
}

module Bearing( aX )
{
    color( "gray" )
    {
        difference()
        {
            translate( [ aX, 0, 0 ] )
                Cylinder_X( BEARING_SX, BEARING_R1, 64 );

            translate( [ aX - EPS, 0, 0 ] )
                Cylinder_X( 2 * EPS + BEARING_SX, BEARING_R0, 64 );
        }
    }
}

module Bearing_Hole( aX, aLength )
{
    translate( [ aX, 0, 0 ] )
        Cylinder_X( aLength, BEARING_R2, 32 );
}

module Screw_Hole( aX )
{
    translate( [ aX, 0, 0 ] )
        M3_Thread_Z( PLANE_Z_TOP + EPS );

    translate( [ aX, 0, PLANE_Z_TOP - 3 ] )
        M3_Head_Z( 3 + EPS );
}

module Slot_Cube( aX )
{
    translate( [ aX, - SIZE_R - EPS, PLANE_Z_0 - ROD_R1 ] )
        cube( [ ROD_R1 + EPS, 2 * EPS + SIZE_Y, ROD_D1 ] );
}

module Slot_Cylinder( aX )
{
    translate( [ aX, - SIZE_R - EPS, PLANE_Z_0 ] )
        Cylinder_Y( 2 * EPS + SIZE_Y, ROD_R1, 32 );
}

BEARING_R0 = ( 25.4 / 4 ) / 2;
BEARING_R1 = ( 25.4 * 5 / 8 ) / 2;
BEARING_SX = 25.4 * 10 / 51;

EPS = 0.1;

ROD_D1 = ( 25.4 / 4 ) + 1;

SIZE_X = 30;

TOP_SY = 12;


BEARING_R2 = BEARING_R1 + 0.1;

ROD_R1 = ROD_D1 / 2;

SIZE_R = BEARING_R2 + 3;


PLANE_Z_0   = ROD_R1 + 5; // Center of the slot
PLANE_Z_TOP = PLANE_Z_0 + ROD_R1 + 5;

SIZE_Y = 2 * SIZE_R;
