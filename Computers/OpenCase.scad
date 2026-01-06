
// Author    Martin Dubois
// Copyright (C) 2025 Martin Dubois
// Product   Models3D
// File      Computer/OpenCase.scad

use <C:\_VC\Base3D\Cylinder.scad>
use <C:\_VC\Base3D\Metric\M3.scad>

// Corner();
Hook();
// translate( [ 120, 0, 0 ] ) Leg();

module Corner()
{
    SIZE = 90;

    intersection()
    {
        difference()
        {
            union()
            {
                Cylinder_Y( SIZE_Y, BORDER_R, 32 );

                translate( [ - BORDER_TICK, 0, - BORDER_TICK ] )
                    cube( [ SIZE, SIZE_Y, SIZE ] );
            }

            translate( [ 0, - EPS, 0 ] )
                Cylinder_Y( 2 * EPS + SIZE_Y, 5, 32 );

            translate( [ 0, WALL_TICK, 0 ] )
                cube( [ SIZE - BORDER_TICK + EPS, SIZE_Y - WALL_TICK + EPS, SIZE - BORDER_TICK + EPS ] );

            translate( [ SIZE - 10, - EPS, SIZE - 10 ] )
                Cylinder_Y( 2 * EPS + WALL_TICK, SIZE - BORDER_TICK - WOOD_TICK, 64 );

            // Screw holes
            for ( d = [ 25, 65 ] )
            {
                ScrewHole_Z( d );

                translate( [ - 10 - EPS, 9, d ] )
                {
                    Cylinder_X( 2 * EPS + 10, 1.7, 16 );
                    Cylinder_X( EPS + 3, 4, 16 );
                }
            }
        }

        translate( [ - BORDER_TICK / 2, 0, - BORDER_TICK / 2 ] )
            Cylinder_Y( SIZE_Y, 85.3, 128 );
    }
}

module Hook()
{
    intersection()
    {
        HOLE_SX = 28;
        HOLE_SY = 21;
        HOLE_SZ = 13;

        PLATE_Y = 5;

        SIZE_Y = HOLE_SY + PLATE_Y;

        difference()
        {
            union()
            {
                translate( [ - HOLE_SX / 2, 0, - HOLE_SZ / 2 ] )
                        cube( [ HOLE_SX, PLATE_Y, HOLE_SZ ] );

                translate( [ - HOLE_SX / 2, SIZE_Y - HOLE_SY, - HOLE_SZ / 2 ] )
                    cube( [ HOLE_SX, HOLE_SY, HOLE_SZ * 2 / 3 ] );
            }

            SCREW_DX = 9;

            for ( x = [ - SCREW_DX, SCREW_DX ] )
            {
                translate( [ x, - EPS, - 2 ] )
                {
                    M3_Head_Y( EPS + 3 );
                    M3_Shank_Y( 2 * EPS + SIZE_Y );
                }
            }

            translate( [ - HOLE_SX / 2 - EPS, - 0.6, - HOLE_SZ / 2 - 1 ] )
            {
                rotate( [ 5, 0, 0 ] )
                    cube( [ 2 * EPS + HOLE_SX, 2, 2 + HOLE_SZ ] );
            }
        }

        scale( [ 1, 1, 0.7 ] )
            Cylinder_Y( SIZE_Y, HOLE_SX / 2 + 1, 64 );
    }
}

module Leg()
{
    intersection()
    {
        difference()
        {
            SCREW_D = 16;
            SIZE_X  = 46;

            union()
            {
                Cylinder_Y( SIZE_Y, BORDER_R, 32 );

                translate( [ - SIZE_X / 2, 0, - BORDER_TICK ] )
                    cube( [ SIZE_X, SIZE_Y, BORDER_TICK + WOOD_TICK ] );
            }

            translate( [ 0, - EPS, 0 ] )
                Cylinder_Y( 2 * EPS + SIZE_Y, 5, 32 );

            translate( [ - SIZE_X / 2 - EPS, WALL_TICK, 0 ] )
                cube( [ 2 * EPS + SIZE_X, SIZE_Y - WALL_TICK + EPS, BORDER_R + EPS ] );

            for ( x = [ - SCREW_D, SCREW_D ] )
            {
                ScrewHole_Z( x );
            }
        }

        translate( [ 0, 0, - BORDER_TICK / 2 ] )
            Cylinder_Y( SIZE_Y, 24, 64 );
    }
}

module ScrewHole_X( aZ )
{
    translate( [ - BORDER_TICK - EPS, 9, aZ ] )
    {
        scalde( [ 1, 1.3, 1 ] )
            Cylinder_X( 2 * EPS + BORDER_TICK, SCREW_R, 16 );

        Cylinder_X( EPS + 3, 4, 16 );
    }
}

module ScrewHole_Z( aX )
{
    translate( [ aX, 9, - BORDER_TICK - EPS ] )
    {
        scale( [ 1, 1.3, 1 ] )
            Cylinder_Z( 2 * EPS + BORDER_TICK, SCREW_R, 16 );

        Cylinder_Z( EPS + 2, 4, 16 );
    }
}

BORDER_R    = 15;
BORDER_TICK = 10;

EPS = 0.1;

SCREW_R = 1.8;

SIZE_Y = 15;

WALL_TICK = 2;

WOOD_TICK = 14;
