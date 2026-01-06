
// Author    Martin Dubois
// Copyright (C) 2025 Martin Dubois
// Product   Models3D
// File      Electronics/LM2596.scad

use <C:\_VC\Base3D\Cylinder.scad>
use <C:\_VC\Base3D\Metric\M2.scad>
use <C:\_VC\Base3D\Metric\M3.scad>

Bottom();
Top();

module Bottom()
{
    difference()
    {
        cube( [ BOTTOM_SX, SIZE_Y, BOTTOM_SZ ] );

        translate( [ - EPS, TICK, BASE_SZ ] )
            cube( [ 2 * EPS + BOTTOM_SX, SIZE_Y - 2 * TICK, BOTTOM_SZ - BASE_SZ + EPS ] );

        // Wire holes

        for ( x = [ WIRE_DX, BOTTOM_SX - WIRE_DX ] )
        {
            for ( y = [ WIRE_DY, SIZE_Y - WIRE_DY ] )
            {
                translate( [ x, y, - EPS ] )
                    Cylinder_Z( 2 * EPS + BASE_SZ, WIRE_R, 32 );
            }
        }

        for ( x = [ - EPS, BOTTOM_SX - WIRE_DX ] )
        {
            for ( y = [ WIRE_DY - WIRE_R, SIZE_Y - WIRE_DY - WIRE_R ] )
            {
                translate( [ x, y, - EPS ] )
                    cube( [ WIRE_DX + EPS, WIRE_D, 2 * EPS + BASE_SZ ] );
            }
        }

        // Screw A holes (Z)

        translate( [ SCREW_A_DX, SIZE_Y - SCREW_A_DY, - EPS ] )
            M2_Thread_Z( 2 * EPS + BASE_SZ );

        translate( [ BOTTOM_SX - SCREW_A_DX, SCREW_A_DY, - EPS ] )
            M2_Thread_Z( 2 * EPS + BASE_SZ );

        // Screw B holes (X)
        for ( x = [ - EPS, BOTTOM_SX - 5 ] )
        {
            translate( [ x, CENTER_Y, SCREW_B_Z ] )
                M2_Thread_X( EPS + 5 );
        }

        // Screw C holes (Y)

        translate( [ SCREW_C_X, - EPS, SCREW_C_Z ] )
            M3_Shank_Y( 2 * EPS + TICK );

        translate( [ SCREW_C_X, SIZE_Y - TICK - EPS, SCREW_C_Z ] )
            M3_Thread_Y( 2 * EPS + TICK );

        // Mounting hole (z)
        translate( [ BOTTOM_SX / 2, CENTER_Y, 0 ] )
        {
            translate( [ 0, 0, - EPS ] )
                M3_Shank_Z( 2 * EPS + BASE_SZ );

            translate( [ 0, 0, TICK ] )
                M3_Head_Z( BASE_SZ - TICK + EPS );
        }
    }
}

module Top()
{
    color( "blue" )
    {
        CORNER_SX = 5;
        CORNER_SY = 4;
        CORNER_SZ = 3;

        SPACE = 0.1;

        SIZE_X = BOTTOM_SX + 2 * SPACE + 2 * TICK;
        SIZE_Z = BOTTOM_SZ + TICK;

        PLANE_X_LEFT = - TICK - SPACE;
        PLANE_X_1    = - SPACE;
        PLANE_X_2    = PLANE_X_LEFT + SIZE_X - TICK;

        PLANE_Z_1 = SIZE_Z - TICK;

        difference()
        {
            translate( [ PLANE_X_LEFT, EPS, 0 ] )
                cube( [ SIZE_X, SIZE_Y - 2 * EPS, SIZE_Z ] );

            translate( [ PLANE_X_1, 0, - EPS ] )
                cube( [ 2 * SPACE + BOTTOM_SX, SIZE_Y, PLANE_Z_1 + EPS ] );

            // Config port
            translate( [ 20, 5, PLANE_Z_1 - EPS ] )
                Cylinder_Z( 2 * EPS + TICK, 3, 16 );

            // Wire holes
            for ( x = [ PLANE_X_LEFT - EPS, PLANE_X_2 - EPS ] )
            {
                for ( y = [ WIRE_DY, SIZE_Y - WIRE_DY ] )
                {
                    translate( [ x, 0, 0 ] )
                    {
                        translate( [ 0, y, WIRE_R ] )
                            Cylinder_X( 2 * EPS + TICK, WIRE_R, 16 );

                        translate( [ 0, y - WIRE_R, - EPS ] )
                            cube( [ 2 * EPS + TICK, WIRE_D, EPS + WIRE_R ] );
                    }
                }
            }

            // Vent
            for ( x = [ 5, 10, 15, 20 ] )
            {
                translate( [ x, x, PLANE_Z_1 - EPS ] )
                    cube( [ x, 2, 2 * EPS + TICK ] );
            }

            // Screw B holes
            for ( x = [ PLANE_X_LEFT - EPS, PLANE_X_2 - EPS ] )
            {
                translate( [ x, CENTER_Y, SCREW_B_Z ] )
                    M2_Shank_X( 2 * EPS + TICK );
            }
        }

        // Screw C
        translate( [ SCREW_C_X, 0, SCREW_C_Z ] )
        {
            difference()
            {
                translate( [ 0, TICK, 0 ] )
                    Cylinder_Y( SIZE_Y - 2 * TICK, SCREW_C_R, 32 );

                translate( [ 0, TICK - EPS, 0 ] )
                    M3_Shank_Y( 2 * EPS + SIZE_Y - 2 * TICK );
            }
        }

        // Corners
        for ( x = [ PLANE_X_1, PLANE_X_2 - CORNER_SX ] )
        {
            for ( y = [ TICK, SIZE_Y - TICK - CORNER_SY ] )
            {
                translate( [ x, y, PLANE_Z_1 - CORNER_SZ ] )
                    cube( [ CORNER_SX, CORNER_SY, CORNER_SZ ] );
            }
        }
    }
}

BASE_SZ = 6;

BOARD_SX = 43;
BOARD_SY = 21;

BOTTOM_SZ = 20;

EPS = 0.1;

// Screw A - M2 - Used to mount board in the bottom part
SCREW_A_DX = 8.5;
SCREW_A_DY = 4.6;

// Screw B - M2 - Used to secure the top on the Base
SCREW_B_Z = 3;

// Screw C - M3 - Used to secure the top on the base
SCREW_C_R = 3.5;
SCREW_C_X = 30;

SPACE = 0.6;

TICK = 2;

WIRE_D  = 4;
WIRE_DX = 4;
WIRE_DY = 4.5;


BOTTOM_SX = BOARD_SX + 2 * TICK;

SCREW_C_Z = BOTTOM_SZ - 3;

SIZE_Y = BOARD_SY + 2 * SPACE + 2 * TICK;

WIRE_R = WIRE_D / 2;


CENTER_Y = SIZE_Y / 2;
