$fn = 100;

hole_M3 = 3.5;
M3_hole = 3.4;
M3_nut_e = 6.4;
M4_hole = 4.4;
M4_nut_e = 7.66+0.5;
M5_nut_e = 8.79+0.5;
M6_nut_e = 11.05+0.5;
t = true;

bb_do = 30.5;
bb_h = 9.2;

bb5_do = 16.5;
bb5_h = 5;


stepper_mount = 31;
stepper_hole = 25;

bar_e = 15;
bar_e2 = bar_e + 0.4;// Bar edge + tolerance


bearing_diameter = 19;
bearing_thickness = 6;
bearing_hole = 5.5; //608 bearings
bearing_space = 1;
spacer_diameter = bearing_hole * 1.8; //608 bearings
spacer_thickness = 1;
tube_edge = 15;
2nd_tube_edge = 15;
2nd_tube_hole = 3.5;
2nd_tube_tolerance = 0.2;
2nd_tube_wall = 3 + 2nd_tube_tolerance;
2nd_tube_nut = 3;

clamp_hole = 3.5;
clamp_length = sqrt(tube_edge * tube_edge * 2) + clamp_hole + 6;
clamp_width = 8;



draw_ball_bearing = 0;


translate([90, 0, 0]){
//  linear_bearing_cutter_bottom();
}

translate([0, 0, 4*0]){
//  linear_bearing_cutter_top();
}

translate([90, 35, 30*0]){
//  cutter_guide();
}

translate([0, -20, 30*0]){
//  cutter_guide_bar();
}

translate([0, 0, 0]){
//  cutter_motor_mount();
}

translate([0, 45, 0]){
//  cutter_belt_mount();
}


translate([0, 35, 40*0]){
  rotate([0, 0, 0]){
//    blade_mount();
  }
}

translate([0, 0, 0]){
//  cutter_bar_mount();
}

translate([-15, 0, 0]){
//  mirror([0,1,0])
//  stepper_mount_belt();
}
translate([4, -15, -5*0]){
//  mirror([0,1,0])
//  belt_mount();
}
translate([-3, -15, 0]){
//  mirror([0,1,0])
//  belt_mount_top();
}

translate([0, 0, -1*0]){
  rotate([180*0, 0, 90]){
//    belt_mount_printhead();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    fork();
  }
}

translate([15, 0, 0]){
//  mirror([0,1,0])
//  stepper_mount_feed();
}

translate([0, -25, 20*0]){
//  top_roller_mount();
}

translate([0, -25, 30]){
  rotate([180, 0, 0]){
//    foot();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    paper_roll_mount();
  }
}

translate([-13, -37.5, -33*0]){
  rotate([0, -45*0+90, 0]){
//    printhead_mount();
  }
}



/*
translate([27.5, -20, -10*0+8]){
  gear(teeth = 25, shaft=5.2, h = 10);
  translate([0, 0, -4]){
    difference(){
      cylinder(d=30, h=8, center=true);
      cylinder(d=5.2, h=10.1, center=true);
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h=50, center=true);
      }
      translate([6, 0, -0.2]){
        cube(size=[3,6.2,8.0], center=true);
      }
    }
  }
}
translate([27.5, 25+8, 0]){
//  gear(teeth = 70, shaft=10.0, h = 9);// Rear feed
  gear(teeth = 60, shaft=10.0, h = 9);// Front feed
}
*/

translate([0, 0, 0]){
  //frame_link();
}


translate([0, 0, 0]){
  //pi_holder();
}



translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    rubber_roller();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    arduino_mount();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    paper_position();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    LCD_mount();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    Pi_mount();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    rail_mount();
  }
}

translate([0, 0, 0]){
  rotate([0, 0, 0]){
//    rail_mount_printhead();
  }
}
translate([0, 45, 0]){
  mirror([0, 1, 0]){
//    rail_mount_printhead();
  }
}


module rail_mount_printhead(){
  r_dis = 60;
  r_d = 15;
  
  rm_l = 40;
  rm_h = 90;
  rm_w = 40;
  rm_gap = 1;
  
  s_dis = 35;
  bb_l = 25;
  
  difference(){
    roundedRect([rm_h,rm_w,rm_l],5);
    // Screw cuts
    translate([s_dis/2, 0, bb_l/2]){
      rotate([90, 30, 0]){
        cylinder(d=6.5, h=rm_w*1.1, center=true);
        translate([0, 0, rm_w/2]){
          cylinder(d=M6_nut_e, h=20, center=true, $fn=6);
        }
      }
    }
    translate([-s_dis/2, 0, bb_l/2]){
      rotate([90, 30, 0]){
        cylinder(d=6.5, h=rm_w*1.1, center=true);
        translate([0, 0, rm_w/2]){
          cylinder(d=M6_nut_e, h=20, center=true, $fn=6);
        }
      }
    }
    // Arduino mount screw cut
    translate([40, -6, rm_l-7.05]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h=20, center=true);
        translate([0, 0, -5])rotate([0, 0, 30]){
          cylinder(d=M3_nut_e, h=13, center=true, $fn=6);
        }
      }
    }
    // Print head mount screw cut
    for(i=[0:1:1])mirror([i,0,0])
    difference(){
      translate([15, 0, rm_l-7.05]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=100, center=true);
          rotate([0, 0, 30]){
            cylinder(d=M3_nut_e, h=30, center=true, $fn=6);
          }
        }
      }
      translate([0, 50, rm_l/2]){
        cube(size=[100, 100, rm_l], center=true);
      }
    }
    // Belt mount screw cut
    // Belt mount screw distance = 69
    // Print head mount screw distance = 60
    difference(){
      translate([10, 0, rm_l-7.5]){
        rotate([90, 0, -45]){
          cylinder(d=M3_hole, h=100, center=true);
          rotate([0, 0, 30]){
            cylinder(d=M3_nut_e, h=22, center=true, $fn=6);
          }
        }
      }
      translate([0, -50, rm_l/2]){
        cube(size=[100, 100, rm_l], center=true);
      }
    }
    // Belt mount cut
    difference(){
      translate([50, 50, rm_l*1.5-15]){
        rotate([0, 0, 45]){
          cube(size=[100, 100, rm_l], center=true);
        }
      }
      translate([0, -50, rm_l/2]){
        cube(size=[100, 100, rm_l], center=true);
      }
    }
    
    // Gap cut
    translate([0, 0, rm_l/2]){
      cube(size=[rm_h*1.1, rm_gap, rm_l*1.1], center=true);
    }
    // Bar cut
    translate([0, 0, rm_l/2]){
      cube(size=[20, 20, rm_l*1.1], center=true);
    }
    // Rail cuts
    translate([r_dis/2, 0, rm_l/2]){
      cylinder(d=r_d, h=rm_l*1.1, center=true);
    }
    translate([-r_dis/2, 0, rm_l/2]){
      cylinder(d=r_d, h=rm_l*1.1, center=true);
    }
  }
  
}

module rail_mount(){
  r_dis = 60;
  r_d = 8;
  
  rm_l = 15;
  rm_h = 80;
  rm_w = 30;
  rm_gap = 1;
  
  s_dis = 40;
  
  difference(){
    roundedRect([rm_h,rm_w,rm_l],5);
    // Screw cuts
    translate([s_dis/2, 0, rm_l/2]){
      rotate([90, 0, 0]){
        cylinder(d=6.5, h=rm_w*1.1, center=true);
        translate([0, 0, rm_w/2]){
          cylinder(d=M6_nut_e, h=10, center=true, $fn=6);
        }
      }
    }
    translate([-s_dis/2, 0, rm_l/2]){
      rotate([90, 0, 0]){
        cylinder(d=6.5, h=rm_w*1.1, center=true);
        translate([0, 0, rm_w/2]){
          cylinder(d=M6_nut_e, h=10, center=true, $fn=6);
        }
      }
    }
    
    // Gap cut
    translate([0, 0, rm_l/2]){
      cube(size=[rm_h*1.1, rm_gap, rm_l*1.1], center=true);
    }
    // Bar cut
    translate([0, 0, rm_l/2]){
      cube(size=[bar_e2, bar_e2, rm_l*1.1], center=true);
    }
    // Rail cuts
    translate([r_dis/2, 0, rm_l/2]){
      cylinder(d=r_d, h=rm_l*1.1, center=true);
    }
    translate([-r_dis/2, 0, rm_l/2]){
      cylinder(d=r_d, h=rm_l*1.1, center=true);
    }
  }
  
}

module arduino_mount(){
  UNOm_l = 95;
  UNOm_w = 110;
  UNOm_h = 30;
  UNOm_wall = 2;
  
  UNO_l = 85;
  
  UNO_s_l = 60;
  UNO_s_y = -15;

  UNO_s_y2 = 0;

  
  SD_cut_x = 15;
  SD_cut_y = -105;
  SD_cut_z = -5;
  SD_cut_w = 35;


  
  // Box
  translate([0, 40, 0]){
    difference(){
      union(){
        roundedRect([UNOm_l,UNOm_w,UNOm_h], 5);
      }
      // Inner cut
      translate([0, 0, UNOm_h/2+UNOm_wall]){
        cube(size=[UNO_l, UNOm_w-2*UNOm_wall, UNOm_h], center=true);
      }
      // Top lid cut
      translate([0, UNOm_wall, UNOm_h-2+0.1]){
        hull(){
          cube(size=[UNO_l, UNOm_w, 4], center=true);
          cube(size=[UNO_l+4, UNOm_w, 0.2], center=true);
        }
      }
      //SD card cut
      translate([SD_cut_x, SD_cut_y, SD_cut_z]){
        cube(size=[SD_cut_w, UNOm_w, UNOm_h], center=true);
      }      
      
      // Ventilation cuts
      for(y=[0:1:5])for(x=[0:1:4]){
        translate([15-UNOm_l/2+16*x,15-UNOm_w/2+y*16, UNOm_wall/2]){
          if(!((y>0 && y<4) && (x==0 || x==4))){
            cylinder(d=10, h=UNOm_wall * 1.1, center=true);
          }
        }      
      }
      // Screw cuts
      translate([0, UNO_s_y, UNOm_wall/2]){
        translate([UNO_s_l/2, UNO_s_y/2, 0]){
          cylinder(d=M3_hole, h=UNOm_wall * 10.1, center=true);
        }
        translate([-UNO_s_l/2, UNO_s_y/2, 0]){
          cylinder(d=M3_hole, h=UNOm_wall * 10.1, center=true);
        }
      }

      translate([0, UNO_s_y2, UNOm_wall/2]){
        translate([UNO_s_l/2, UNO_s_y2/2, 0]){
          cylinder(d=M3_hole, h=UNOm_wall * 10.1, center=true);
        }
        translate([-UNO_s_l/2, UNO_s_y2/2, 0]){
          cylinder(d=M3_hole, h=UNOm_wall * 10.1, center=true);
        }
      }
    }
  }


}

module Pi_mount(){
  PIm_l = 130;
  PIm_w = 160;
  PIm_h = 35;
  PIm_wall = 2;
  
  PI_l = 120;
  
  PI_s_l = 80;
  PI_s_w = 125;
  PI_s_y = 7;

  //Raspberry Pi mount point
  raspi_m_l = 58;
  raspi_m_w = 49;
  raspi_m_shift_x = 22;
  raspi_m_shift_y = 45;
  raspi_m_d = 5;
  raspi_m_screw_d = 2;
  raspi_m_h = 6;
  raspi_m_socket = 1;
  
  SD_cut_x = 110;
  SD_cut_y = 45;
  SD_cut_z = 0;
  SD_cut_w = 30;


  
  // Box
  translate([0, 40, 0]){
    difference(){
      union(){
        roundedRect([PIm_l,PIm_w,PIm_h], 5);
      }
      // Inner cut
      translate([0, 0, PIm_h/2+PIm_wall]){
        cube(size=[PI_l, PIm_w-2*PIm_wall, PIm_h], center=true);
      }
      // Top lid cut
      translate([0, PIm_wall, PIm_h-2+0.1]){
        hull(){
          cube(size=[PI_l, PIm_w, 4], center=true);
          cube(size=[PI_l+4, PIm_w, 0.2], center=true);
        }
      }
      //SD card cut
      translate([SD_cut_x, SD_cut_y, SD_cut_z]){
        cube(size=[PIm_l, SD_cut_w, PIm_h], center=true);
      }      
      
      // Ventilation cuts
      for(y=[0:1:8])for(x=[0:1:6]){
        translate([15-PIm_l/2+16*x,10-PIm_w/2+y*16, PIm_wall/2]){
          if(!(x==3 && y==6) &&
             !(x==6 && y==6) &&
             !(x==6 && y==7) &&
             !(x==6 && y==8)){
            cylinder(d=10, h=PIm_wall * 1.1, center=true);
          }
        }      
      }
      // Screw cuts
      translate([0, PI_s_y, PIm_wall/2]){
        translate([PI_s_l/2, PI_s_w/2, 0]){
          cylinder(d=M3_hole, h=PIm_wall * 1.1, center=true);
        }
        translate([-PI_s_l/2, PI_s_w/2, 0]){
          cylinder(d=M3_hole, h=PIm_wall * 1.1, center=true);
        }
      }
    }
    //Pi mount points
    translate([raspi_m_shift_x, raspi_m_shift_y, PIm_wall/2]){
      translate([raspi_m_l/2, raspi_m_w/2, raspi_m_h/2]){
        difference(){
          cylinder(d2=raspi_m_d, d1=8, h=raspi_m_h, center=true);
          cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
        }
      }
      translate([raspi_m_l/2, -raspi_m_w/2, raspi_m_h/2]){
        difference(){
          cylinder(d2=raspi_m_d, d1=8, h=raspi_m_h, center=true);
          cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
        }
      }
      translate([-raspi_m_l/2, raspi_m_w/2, raspi_m_h/2]){
        difference(){
          cylinder(d2=raspi_m_d, d1=8, h=raspi_m_h, center=true);
          cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
        }
      }
      translate([-raspi_m_l/2, -raspi_m_w/2, raspi_m_h/2]){
        difference(){
          cylinder(d2=raspi_m_d, d1=8, h=raspi_m_h, center=true);
          cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
        }
      }
    }
  }


}


module LCD_mount(){
  LCDm_l = 95;
  LCDm_w = 60;
  LCDm_h = 24;
  LCDm_wall = 2;
  
  LCD_l = 85;
  
  LCD_s_l = 75;
  LCD_s_w = 31;
  LCD_s_y = 7;
  
  // Box
  translate([0, 40, 0]){
    difference(){
      union(){
        roundedRect([LCDm_l,LCDm_w,LCDm_h], 5);
        // Front mount
        difference(){
          hull(){
            translate([0, -LCDm_h, LCDm_h-2]){
              cube(size=[20, LCDm_w+LCDm_h, 2], center=true);
            }
            translate([0, 0, 1]){
              cube(size=[20, LCDm_w, 2], center=true);
            }
          }
          translate([0, 3, 3]){
            hull(){
              translate([0, -LCDm_h, LCDm_h-2]){
                cube(size=[15, LCDm_w+LCDm_h, 2], center=true);
              }
              translate([0, 0, 1]){
                cube(size=[15, LCDm_w, 2], center=true);
              }
            }
          }
          translate([0, -LCDm_w/2, 0]){
            rotate([-45, 0, 0]){
              translate([0, -15, 0]){
                cylinder(d=M3_hole, h=LCDm_h, center=true);
              }
              translate([0, -35, 0]){
                cylinder(d=M3_hole, h=LCDm_h, center=true);
              }
            }
          }
        }
      }
      // Inner cut
      translate([0, 0, LCDm_h/2+LCDm_wall]){
        cube(size=[LCD_l, LCDm_w-2*LCDm_wall, LCDm_h], center=true);
      }
      // Top lid cut
      translate([0, LCDm_wall, LCDm_h-2+0.1]){
        hull(){
          cube(size=[LCD_l, LCDm_w, 4], center=true);
          cube(size=[LCD_l+4, LCDm_w, 0.2], center=true);
        }
      }
      // Cable cut
      translate([0, 6-LCDm_w/2, LCDm_wall/2]){
        cylinder(d=6, h=LCDm_wall * 1.1, center=true);
      }      
      // Screw cuts
      translate([0, LCD_s_y, LCDm_wall/2]){
        translate([LCD_s_l/2, LCD_s_w/2, 0]){
          cylinder(d=M3_hole, h=LCDm_wall * 1.1, center=true);
        }
        translate([-LCD_s_l/2, LCD_s_w/2, 0]){
          cylinder(d=M3_hole, h=LCDm_wall * 1.1, center=true);
        }
        translate([-LCD_s_l/2, -LCD_s_w/2, 0]){
          cylinder(d=M3_hole, h=LCDm_wall * 1.1, center=true);
        }
        translate([LCD_s_l/2, -LCD_s_w/2, 0]){
          cylinder(d=M3_hole, h=LCDm_wall * 1.1, center=true);
        }
      }
    }
  }
}


module paper_position(){
  pp_h = 93;
  pp_di = 12;
  pp_wall = 2.5;
  pp_do = pp_di + 2 * pp_wall;
  
  translate([0, 0, pp_h/2]){
    difference(){
      union(){
        hull(){
          translate([0, 0, (pp_wall-pp_h)/2+5]){
            cylinder(d=pp_do, h=pp_wall, center=true);
          }
          translate([0, 0, (pp_wall-pp_h)/2]){
            cylinder(d=30, h=pp_wall, center=true);
          }
        }
        cylinder(d=pp_do, h=pp_h, center=true);
      }
      cylinder(d=pp_di, h=pp_h*1.1, center=true);
    }
  }
  
}
module cutter_bar_mount(){
  bm_h = 15;
  bm_w = 30;
  bm_l = 15;
  
  difference(){
    hull(){
      translate([bm_w/2, 0, bm_h/2]){
        cylinder(d=bm_l, h=bm_h, center=true);
      }
      translate([-bm_w/2, 0, bm_h/2]){
        cylinder(d=bm_l, h=bm_h, center=true);
      }
    }
    // Mount holes
    translate([bm_w/2, 0, bm_h/2]){
      cylinder(d=6.5, h=bm_h*1.1, center=true);
    }
    translate([-bm_w/2, 0, bm_h/2]){
      cylinder(d=6.5, h=bm_h*1.1, center=true);
    }
    // Bar cut
    translate([0, 0, bm_h]){
      rotate([0, 45, 0]){
        cube(size=[bar_e, bm_l*1.1, bar_e], center=t);
      }
    }
  }
  
}


module rubber_roller(){
  difference(){
    cylinder(d=14, h=20, center=true);
    cylinder(d=10, h=21, center=true);
  }
}

module pi_holder(){
  hole1_d = 20;
  hole1_x = -17;
  hole1_y = 15;

  hole2_d = 12;
  hole2_x = -42;
  hole2_y = 33;

  hole3_d = 12;
  hole3_x = -42;
  hole3_y = 40;
  
  raspi_m_l = 58;
  raspi_m_w = 49;
  raspi_m_x = 20;
  raspi_m_y = 18;
  raspi_m_d = 5;
  raspi_m_screw_d = 2;
  raspi_m_h = 6;
  raspi_m_socket = 1;
  raspi_card_w = 30;
  raspi_card_h = 3;
  
  voltage_x = -30;
  voltage_y = -27;
  voltage_d = 20;

  heatsink_l = 56;
  heatsink_h = 10;
  heatsink_x = -30;
  heatsink_y = 27;
  heatsink_m = 35;

  width = 110;
  length = 110;
  height = 7;
  wall = 2;
  
  mount_w = bearing_diameter * 2 + 2nd_tube_edge + 2nd_tube_wall * 2 +bearing_space * 2 + 2nd_tube_nut * 2 + bearing_space * 2 + clamp_width;
  mount_l = clamp_length;
  
  
  
  translate([0, 0, wall/2]){
    difference(){
      cube(size=[length, width, wall], center=true);
      //Holes
      translate([hole1_x, hole1_y, 0]){
        cylinder(d=hole1_d, h=wall*1.1, center=true);
      }
      translate([hole2_x, hole2_y, 0]){
        cylinder(d=hole2_d, h=wall*1.1, center=true);
      }
      translate([hole3_x, -hole3_y, 0]){
        cylinder(d=hole2_d, h=wall*1.1, center=true);
      }
      translate([-hole3_x, -hole3_y, 0]){
        cylinder(d=hole2_d, h=wall*1.1, center=true);
      }
      translate([-hole2_x, hole2_y, 0]){
        cylinder(d=hole2_d, h=wall*1.1, center=true);
      }
      
      //Mounts linear bearing
      translate([mount_l/2, mount_w/2, 0]){
        cylinder(d=hole_M3, h=wall*1.1, center=true);
      }
      translate([mount_l/2, -mount_w/2, 0]){
        cylinder(d=hole_M3, h=wall*1.1, center=true);
      }
      translate([-mount_l/2, mount_w/2, 0]){
        cylinder(d=hole_M3, h=wall*1.1, center=true);
      }
      translate([-mount_l/2, -mount_w/2, 0]){
        cylinder(d=hole_M3, h=wall*1.1, center=true);
      }
    }
  }
  //walls
  translate([0, (width-wall)/2, height/2]){
    difference(){
      cube(size=[length, wall, height], center=true);
      translate([raspi_m_x, 0, height/2]){
        cube(size=[raspi_card_w, wall*1.1, raspi_card_h*2], center=true);
      }
    }
  }
  translate([0, (wall-width)/2, height/2]){
    cube(size=[length, wall, height], center=true);
  }
  translate([(length-wall)/2, 0, height/2]){
    cube(size=[wall, width, height], center=true);
  }
  translate([(wall-length)/2, 0, height/2]){
    cube(size=[wall, width, height], center=true);
  }

  //Mount points voltage regulator
  translate([voltage_x, voltage_y+voltage_d/2, (wall+raspi_m_h)/2]){
    difference(){
      cylinder(d=raspi_m_d, h=raspi_m_h, center=true);
      cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
    }
  }
  translate([voltage_x, voltage_y-voltage_d/2, (wall+raspi_m_h)/2]){
    difference(){
      cylinder(d=raspi_m_d, h=raspi_m_h, center=true);
      cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
    }
  }

  //Mount points Raspberry Pi
  translate([raspi_m_w/2+raspi_m_x, raspi_m_y-raspi_m_l/2, (wall+raspi_m_h)/2]){
    difference(){
      cylinder(d=raspi_m_d, h=raspi_m_h, center=true);
      cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
    }
  }
  translate([-raspi_m_w/2+raspi_m_x, raspi_m_y-raspi_m_l/2, (wall+raspi_m_h)/2]){
    difference(){
      cylinder(d=raspi_m_d, h=raspi_m_h, center=true);
      cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
    }
  }
  translate([raspi_m_w/2+raspi_m_x, raspi_m_y+raspi_m_l/2, (wall+raspi_m_h)/2]){
    difference(){
      cylinder(d=raspi_m_d, h=raspi_m_h, center=true);
      cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
    }
  }
  translate([-raspi_m_w/2+raspi_m_x, raspi_m_y+raspi_m_l/2, (wall+raspi_m_h)/2]){
    difference(){
      cylinder(d=raspi_m_d, h=raspi_m_h, center=true);
      cylinder(d=raspi_m_screw_d, h=raspi_m_h*1.1, center=true);
    }
  }
  
  //Heatsink mount
  translate([heatsink_x, heatsink_y, (heatsink_h+wall)/2]){
    translate([0, (heatsink_l-wall)/2, -heatsink_h/2]){
      rotate([90, 0, 0]){
        difference(){
          cylinder(r=heatsink_h, h=wall, center=true);
          translate([0, -heatsink_h, 0]){
            cube(size=[heatsink_h*2, heatsink_h*2, heatsink_h*2], center=true);
          }
        }
      }
    }
    translate([0, -(heatsink_l-wall)/2, -heatsink_h/2]){
      rotate([90, 0, 0]){
        difference(){
          cylinder(r=heatsink_h, h=wall, center=true);
          translate([0, -heatsink_h, 0]){
            cube(size=[heatsink_h*2, heatsink_h*2, heatsink_h*2], center=true);
          }
        }
      }
    }
    difference(){
      cube(size=[wall, heatsink_l, heatsink_h], center=true);
      translate([0, heatsink_m/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=hole_M3, h=wall*1.1, center=true);
        }
      }
      translate([0, -heatsink_m/2, 0]){
        rotate([0, 90, 0]){
          cylinder(d=hole_M3, h=wall*1.1, center=true);
        }
      }
    }
  }

}


module frame_link(){
  length = 40;
  wall = 2.2;
  tolerance = 0.2;
  shift = 1;
  tube_edge2=tube_edge+tolerance;
  
  round_edge = 10;

  x1=0;
  y1=round_edge;
  x2=0;
  y2=length;
  x3=tube_edge+wall*2;
  y3=length;
  x4=length;
  y4=tube_edge+wall*2;
  x5=length;
  y5=0;
  x6=round_edge;
  y6=0;
  
  
  difference(){
    linear_extrude(height=(tube_edge+wall*2)/2){
      polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4],[x5,y5],[x6,y6]]);
    }
    translate([tube_edge/2+wall, length/2+wall+tube_edge2+shift, tube_edge/2 + wall]){
      cube(size=[tube_edge2, length, tube_edge], center=true);
    }
    translate([length/2+wall+tube_edge2+shift, tube_edge/2+wall, tube_edge/2 + wall]){
      cube(size=[length, tube_edge2, tube_edge], center=true);
    }

    translate([tube_edge/2+wall, tube_edge/2+wall, (tube_edge-wall)/2]){
      cylinder(d=hole_M3, h=tube_edge, center=true);
    }
    translate([length*3/4+wall, tube_edge/2+wall, (tube_edge-wall)/2]){
      cylinder(d=hole_M3, h=tube_edge, center=true);
    }
    translate([tube_edge/2+wall, length*3/4+wall, (tube_edge-wall)/2]){
      cylinder(d=hole_M3, h=tube_edge, center=true);
    }
  }

}

module stepper_mount_belt(){
  sm_wall = 2;
  sm_w = 80;
  sm_l = 70;
  sm_shift_y = 15;
  
  s_shift_x = 12.5;
  s_shift_y = -15;
  
  long_hole = 5;

  difference(){
    roundedRect([sm_l,sm_w,sm_wall],5,[0,1,0,1]);
    // 2nd bar mount holes
    translate([(bar_e-sm_l)/2, sm_shift_y, 0]){
      cylinder(d=M4_hole, h=sm_wall*2.1, center=true);
    }
    translate([(bar_e-sm_l)/2+20, sm_shift_y, 0]){
      cylinder(d=M4_hole, h=sm_wall*2.1, center=true);
    }
    translate([-(bar_e-sm_l)/2, sm_shift_y, 0]){
      cylinder(d=M4_hole, h=sm_wall*2.1, center=true);
    }
    //Motor holes
    translate([s_shift_x, s_shift_y, sm_wall/2]){
      hull(){
        translate([long_hole/2, 0, 0]){
          cylinder(d=stepper_hole, h = sm_wall*1.1, center=true);
        }
        translate([-long_hole/2, 0, 0]){
          cylinder(d=stepper_hole, h = sm_wall*1.1, center=true);
        }
      }

      hull(){
        translate([(stepper_mount+long_hole)/2, stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
        translate([(stepper_mount-long_hole)/2, stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
      }
      hull(){
        translate([(stepper_mount+long_hole)/2, -stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
        translate([(stepper_mount-long_hole)/2, -stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
      }
      hull(){
        translate([(-stepper_mount+long_hole)/2, -stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
        translate([(-stepper_mount-long_hole)/2, -stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
      }
      hull(){
        translate([(-stepper_mount+long_hole)/2, stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
        translate([(-stepper_mount-long_hole)/2, stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
        }
      }
    }
  }
  // Enforcement
  for(i=[0:1:1])mirror([0,i,0]){
    hull(){
      translate([12.5, (sm_w-sm_wall)/2, sm_wall]){
        cube(size=[35, sm_wall, 0.1], center=true);
      }
      translate([bar_e2+2*sm_wall-sm_l/2, (sm_w-sm_wall)/2, bar_e2]){
        cube(size=[0.1, sm_wall, bar_e2*2], center=true);
      }
    }
  }
  // Frame mounts
  difference(){
    union(){
      translate([-(sm_l-sm_wall)/2, 0, bar_e2]){
        cube(size=[sm_wall, sm_w, 2*bar_e2], center=true);
      }
      translate([bar_e2+sm_wall-(sm_l-sm_wall)/2, 0, bar_e2]){
        cube(size=[sm_wall, sm_w, 2*bar_e2], center=true);
      }
    }
    translate([-sm_l/2*0, sm_shift_y, sm_wall+bar_e2/2]){
      cube(size=[sm_l*1.1, bar_e2, bar_e2], center=true);
    }
    translate([0, sm_w/2-7, sm_wall+1.5*bar_e2]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h = sm_l*1.1, center=true);
      }
    }
    translate([0, 7-sm_w/2, sm_wall+1.5*bar_e2]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h = sm_l*1.1, center=true);
      }
    }
  }
  translate([0, sm_shift_y, 0]){
    difference(){
      a = sm_wall-(sm_l-bar_e2)/2;
      b = (bar_e2+sm_wall)/2;
      c = bar_e2/2+sm_wall;
      union(){
        translate([a, b, c]){
          cube(size=[bar_e2, sm_wall, bar_e2], center=true);
        }
        translate([a, -b, c]){
          cube(size=[bar_e2, sm_wall, bar_e2], center=true);
        }
      }
      translate([a, 0, c]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=sm_w, center=true);
        }
      }
    }
  }  
}

module foot(){
  pm_wb = 12;
  pm_wt = 50;
  pm_l = 180;
  pm_h = 30;
  pm_h2 = 10;
  pm_wall = 2;
  
  difference(){
    hull(){
      for(i=[0:1:1])mirror([0,i,0]){
        translate([pm_l/2, pm_wb/2, pm_h-pm_h2/2]){
          cylinder(d=5, h=pm_h2, center=true);
        }
        translate([-pm_l/2, pm_wt/2, pm_h/2]){
          cylinder(d=5, h=pm_h, center=true);
        }
      }
    }
    difference(){
      hull(){
        for(i=[0:1:1])mirror([0,i,0]){
          translate([pm_l/2-pm_wall, pm_wb/2-pm_wall, pm_h/2]){
            cylinder(d=5, h=pm_h*1.1, center=true);
          }
          translate([-pm_l/2+pm_wall, pm_wt/2-pm_wall, pm_h/2]){
            cylinder(d=5, h=pm_h*1.1, center=true);
          }
        }
      }
      translate([0, 0, pm_h+3]){
        cube(size=[pm_l*1.1,10.5+2*pm_wall,pm_h], center=true);
      }
      translate([-0, 0, pm_h-12]){
        rotate([0, 90, 0]){
         cylinder(d=10.5+2*pm_wall, h=pm_l*1.1, center=true);
        }
      }
    }
    for(i=[0:1:1])mirror([0,i,0]){
      translate([bar_e/2+pm_wall-pm_l/2, 15,bar_e2/2]){
        rotate([0, 90, 0]){
          cylinder(d=6.5, h=50, center=true);
        }
      }
    }
    translate([pm_l/2-5, 0, pm_h/2]){
      cylinder(d=6.5, h=pm_h*1.1, center=true);
    }
    translate([pm_l/2-5, 0, pm_h/2-4]){
      rotate([0, 0, 30]){
        cylinder(d=M6_nut_e, h=pm_h, center=true, $fn=6);
      }
    }
    translate([-70, 0, pm_h]){
      cube(size=[pm_l, 10.2, 20], center=true);
    }
    translate([-70, 0, pm_h-10]){
      rotate([0, 90, 0]){
       cylinder(d=10.2, h=pm_l, center=true);
      }
    }
  }
}

module paper_roll_mount(){
  rm_d1 = 51;
  rm_d2 = 49;
  rm_d3 = 60;
  rm_di = bb_do-5;
  rm_h = 20;
  rm_wall = 2;
  
  bb_mount_r = 20;
  
  difference(){
    union(){
      translate([0, 0, rm_h/2]){
        cylinder(d1=rm_d1, d2=rm_d2, h=rm_h, center=true);
      }
      translate([0, 0, rm_wall/2]){
        cylinder(d=rm_d3, h=rm_wall, center=true);
      }
    }
    translate([0, 0, rm_h/2]){
      cylinder(d=rm_di, h=rm_h*1.1, center=true);
    }    
    translate([0, 0, rm_h-bb_h/2+0.1]){
      cylinder(d=bb_do, h=bb_h, center=true);
    }    
      for(i=[0:120:360]){
        rotate([0, 0, i]){
          translate([bb_mount_r, 0, rm_h/2]){
            cylinder(d=M3_hole, h=rm_h*1.1, center=true);
          }
        }
      }
  }
  
  // Top plate
  translate([60, 0, rm_wall/2]){
    difference(){
      cylinder(d=rm_d2, h=rm_wall, center=true);
      cylinder(d=rm_di, h=rm_wall*1.1, center=true);
      for(i=[0:120:360]){
        rotate([0, 0, i]){
          translate([bb_mount_r, 0, 0]){
            cylinder(d=M3_hole, h=rm_wall*1.1, center=true);
          }
        }
      }
    }
  }  
  
}

module top_roller_mount(trm_gap = 10.2){
  trm_w = 25;
  trm_l = 35;
  trm_h = 15;
  trm_wall = 2;
  
  difference(){
    roundedRect([trm_l, trm_w, trm_h],5,[1,1,1,1]);
    translate([bar_e/2+trm_wall-trm_l/2, 7.5, trm_h/2]){
      cylinder(d=M3_hole, h=trm_h*1.1, center=true);
    }
    translate([bar_e/2+trm_wall-trm_l/2, -7.5, trm_h/2]){
      cylinder(d=M3_hole, h=trm_h*1.1, center=true);
    }
    translate([0, 0, trm_h/2+trm_wall]){
      cube(size=[trm_l*1.1, trm_gap, trm_h], center=true);
    }
  }
}

module belt_mount(){
  
  sm_wall = 2;
  sm_w = 40;
  sm_l = 45;
  sm_shift_y = 15;
  
  s_shift_x = 12.5;
  s_shift_y = -20;

  bb_shift_x = 5;
  bb_shift_y = 0;
  long_hole = 4;

  difference(){
    union(){
      roundedRect([sm_l,sm_w,5],5,[1,1,1,1]);
      translate([bb_shift_x, bb_shift_y, sm_wall+bb5_h/2+1]){
//        roundedRect([26,26,bb6_h],5,[1,1,1,1]);
        cylinder(d=bb5_do+4, h = bb5_h+2, center=true);
        translate([bb5_do/4+1, 0, 0]){
          cube(size=[bb5_do/2+2,bb5_do+4,bb5_h+2], center=true);
        }
      }
    }
    // Axis hole
    translate([bb_shift_x*1.5, bb_shift_y, sm_wall/2]){
      cylinder(d=bb5_do-5, h = sm_wall*1.1, center=true);
    }
    //Mount holes
    translate([bb_shift_x*0, bb_shift_y, sm_wall/2]){
      for(i=[0:1:1])mirror([i,0,0]){
        translate([(stepper_mount)/2, stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*10.1, center=true);
          translate([0, 0, sm_wall/2+2.5]){
            cylinder(d=M3_nut_e, h = 5, center=true, $fn=6);
          }
        }
        translate([(stepper_mount)/2, -stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = sm_wall*10.1, center=true);
          translate([0, 0, sm_wall/2+2.5]){
            cylinder(d=M3_nut_e, h = 5, center=true, $fn=6);
          }
        }
      }
    }
    // Ball bearing hole2
    translate([bb_shift_x, bb_shift_y, sm_wall+bb5_h/2-.5]){
      hull(){
        cylinder(d=bb5_do, h=bb5_h-1, center=true);
        translate([bb_shift_x, bb_shift_y, bb5_h/2+2]){
          cylinder(d1=bb5_do, d2=bb5_do-7, h=6+0.1, center=true);
        }
        translate([40, 0, 0]){
          cylinder(d=bb5_do, h=bb5_h-1, center=true);
          translate([bb_shift_x, bb_shift_y, bb5_h/2+2]){
            cylinder(d1=bb5_do, d2=bb5_do-7, h=6+0.1, center=true);
          }
        }
      }
    }
  }
}

module belt_mount_top(){
  bm_h = 30;
  
  sm_wall = 2;
  sm_w = 45;
  sm_l = 57;
  
  bb_shift_x = 7;
  bb_shift_y = 0;
  long_hole = 4;

  difference(){
    union(){
      roundedRect([sm_l,sm_w,bm_h],5,[1,1,1,1]);
      translate([bb_shift_x, bb_shift_y, sm_wall+bb5_h/2+1]){
//        roundedRect([26,26,bb6_h],5,[1,1,1,1]);
        cylinder(d=bb5_do+4, h = bb5_h+2, center=true);
        translate([bb5_do/4+1, 0, 0]){
          cube(size=[bb5_do/2+2,bb5_do+4,bb5_h+2], center=true);
        }
      }
    }
    //Mount holes
    translate([bb_shift_x, bb_shift_y, bm_h/2]){
      hull(){
        cylinder(d=bb5_do-5, h = sm_wall*1.1, center=true);
      }
      for(i=[0:1:1])mirror([i,0,0]){
        translate([stepper_mount/2, stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = bm_h*1.1, center=true);
          translate([0, 0, bm_h/2-3]){
            cylinder(d1=6, d2=M3_hole, h = 3.1, center=true);
          }
          translate([0, 0, -6]){
            cylinder(d=6, h = bm_h*1.1, center=true);
          }
        }
        translate([(stepper_mount)/2, -stepper_mount/2, 0]){
          cylinder(d=M3_hole, h = bm_h*1.1, center=true);
          translate([0, 0, bm_h/2-3]){
            cylinder(d1=6, d2=M3_hole, h = 3.1, center=true);
          }
          translate([0, 0, -6]){
            cylinder(d=6, h = bm_h*1.1, center=true);
          }
        }
      }
    }
    // Belt cut
    bm_h2 = bm_h - (bb5_h+4);
    translate([bb_shift_x, bb_shift_y, bm_h - bm_h2/2+2]){
      hull(){
        translate([bb_shift_x, bb_shift_y, 0]){
          cylinder(d=bb5_do+6, h=bm_h2, center=true);
        }
        translate([-45, 0, 0]){
            cylinder(d=bb5_do+6, h=bm_h2, center=true);
        }
      }
    }
    
    translate([bb_shift_x*2, bb_shift_y, bm_h/2]){
      cylinder(d=bb5_do-7, h=bm_h*1.1, center=true);
    }
    
    // Ball bearing hole2
    translate([bb_shift_x, bb_shift_y, sm_wall+bb5_h/2-.5]){
      hull(){
        translate([bb_shift_x, bb_shift_y, 0]){
          cylinder(d=bb5_do, h=bb5_h-1, center=true);
        }
          translate([bb_shift_x, bb_shift_y, bb5_h/2+12]){
            cylinder(d1=1, d2=1, h=bb5_h-1, center=true);
          }
        translate([22, 0, 0]){
          cylinder(d=bb5_do, h=bb5_h-1, center=true);
          translate([bb_shift_x, bb_shift_y, bb5_h/2+12]){
            cylinder(d1=1, d2=1, h=bb5_h-1, center=true);
          }
        }
      }
    }
  }
}


module stepper_mount_feed(){
  sm_wall = 2;
  sm_w = 90;
  sm_l = 70;
  sm_shift_y = 15;
  
  s_shift_x = 12.5;
  s_shift_y = -20;

  bb_shift_x = 12.5;
  bb_shift_y = 24.5;
  long_hole = 5;

  difference(){
    union(){
      roundedRect([sm_l,sm_w,sm_wall],5,[0,1,0,1]);
      translate([bb_shift_x, bb_shift_y, sm_wall]){
        roundedRect([37,37,bb_h],5,[1,1,1,1]);
      }
    }
    //Motor holes
    translate([s_shift_x, s_shift_y, sm_wall/2]){
      hull(){
        cylinder(d=stepper_hole, h = sm_wall*1.1, center=true);
        translate([0,long_hole,0]){
          cylinder(d=stepper_hole, h = sm_wall*1.1, center=true);
        }
      }
      translate([stepper_mount/2, stepper_mount/2, 0]){
        hull(){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          translate([0,long_hole,0]){
            cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          }
        }
      }
      translate([stepper_mount/2, -stepper_mount/2, 0]){
        hull(){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          translate([0,long_hole,0]){
            cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          }
        }
      }
      translate([-stepper_mount/2, stepper_mount/2, 0]){
        hull(){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          translate([0,long_hole,0]){
            cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          }
        }
      }
      translate([-stepper_mount/2, -stepper_mount/2, 0]){
        hull(){
          cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          translate([0,long_hole,0]){
            cylinder(d=M3_hole, h = sm_wall*1.1, center=true);
          }
        }
      }
    }
    // Ball bearing hole2
    translate([bb_shift_x, bb_shift_y, sm_wall+bb_h/2+0.1]){
      cylinder(d=bb_do, h=bb_h+0.2, center=true);
      cylinder(d=bb_do-5, h=bb_h*2, center=true);
      translate([15,15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
      translate([-15,15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
      translate([15,-15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
      translate([-15,-15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
    }    
    translate([bar_e/2+sm_wall-sm_l/2, bb_shift_y+7.5, 0]){
      cylinder(d=M3_hole, h=bb_h*2, center=true);
    }
    translate([bar_e/2+sm_wall-sm_l/2, bb_shift_y-7.5, 0]){
      cylinder(d=M3_hole, h=bb_h*2, center=true);
    }
  }
  // Enforcement
  for(i=[0:1:1])mirror([0,i,0]){
    hull(){
      translate([12.5, (sm_w-sm_wall)/2, sm_wall]){
        cube(size=[35, sm_wall, 0.1], center=true);
      }
      translate([bar_e2+2*sm_wall-sm_l/2, (sm_w-sm_wall)/2, bar_e2/2+sm_wall]){
        cube(size=[0.1, sm_wall, bar_e2], center=true);
      }
    }
  }
  // Frame mounts
  difference(){
    union(){
      translate([-(sm_l-sm_wall)/2, 0, bar_e2/2+sm_wall]){
        cube(size=[sm_wall, sm_w, bar_e2], center=true);
      }
      translate([bar_e2+sm_wall-(sm_l-sm_wall)/2, 0, bar_e2/2+sm_wall]){
        cube(size=[sm_wall, sm_w, bar_e2], center=true);
      }
    }
    translate([0, sm_w/2-7, sm_wall+0.5*bar_e2]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h = sm_l*1.1, center=true);
      }
    }
    translate([0, 7-sm_w/2, sm_wall+0.5*bar_e2]){
      rotate([0, 90, 0]){
        cylinder(d=M3_hole, h = sm_l*1.1, center=true);
      }
    }
  }
  
  // ball bearing top plate
  translate([-55, 25, 0]){
    difference(){
      roundedRect([37,37,sm_wall*2],5,[1,1,1,1]);
      cylinder(d=bb_do-5, h=bb_h*2, center=true);
      translate([15,15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
      translate([-15,15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
      translate([15,-15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
      translate([-15,-15,0]){
        cylinder(d=M3_hole, h=bb_h*2, center=true);
      }
    }
  }
}


module stepper_mount(){
  m_distance = 31;
  m_d = 7;
  m_d2 = 10;
  m_hole = 3.5;
  hole_edge_w = 6;
  hole_edge_l = 4;
  
  motor_edge = 25;
  motor_hole = 25;
  
  cut_d = 20;
  cut_edge = 10;
  
  wall_height = 10;
  wall_distance = 55;
  
  length = bearing_diameter * 2 + 2nd_tube_edge + 2nd_tube_wall * 2 +bearing_space * 2 + 2nd_tube_nut * 2 + bearing_space * 2 + clamp_width*2+8;
  
  width = sqrt(tube_edge * tube_edge * 2) + clamp_hole + 6 + 39;
  wall = 2.5;
  
  x1w=-width/2;
  y1w=0;
  x2w=-width/2+wall_height;
  y2w=wall_height;
  x3w=width/2-wall_height;
  y3w=wall_height;
  x4w=width/2;
  y4w=0;


  translate([0, 0, wall/2]){
    //Enforcements  
    translate([0, wall_distance/2, 0]){
      rotate([90, 0, 0]){
        linear_extrude(height=wall){
          polygon(points=[[x1w,y1w],[x2w,y2w],[x3w,y3w],[x4w,y4w]]);
        }
      }
    }
    translate([0, -wall_distance/2, 0]){
      rotate([90, 0, 0]){
        linear_extrude(height=wall){
          polygon(points=[[x1w,y1w],[x2w,y2w],[x3w,y3w],[x4w,y4w]]);
        }
      }
    }
    
    difference(){
      b_cut_1=10;
      b_cut_2 = 5;
      x1b=-width/2;
      y1b=length/2-b_cut_1;
      x2b=-width/2+b_cut_1;
      y2b=length/2;
      x3b=width/2-b_cut_2;
      y3b=length/2;
      x4b=width/2;
      y4b=length/2-b_cut_2;
      x5b=width/2;
      y5b=-length/2+b_cut_2;
      x6b=width/2-b_cut_2;
      y6b=-length/2;
      x7b=-width/2+b_cut_1;
      y7b=-length/2;
      x8b=-width/2;
      y8b=-length/2+b_cut_1;
      
      linear_extrude(height=wall, center=true){
        polygon(points=[[x1b,y1b],[x2b,y2b],[x3b,y3b],[x4b,y4b],
                         [x5b,y5b],[x6b,y6b],[x7b,y7b],[x8b,y8b]]);
      }
      //cube(size=[width, length, wall], center=true);
      //Cut
      translate([width/2-cut_edge, 0, 0]){
        cylinder(d=cut_d, h = wall*1.1, center=true);
      }
      translate([width/2, 0, 0]){
        cube(size=[cut_edge*2, cut_d, wall*1.1], center=true);
      }
      
      //Motor holes
      translate([-width/2+motor_edge, 0, 0]){
        cylinder(d=motor_hole, h = wall*1.1, center=true);
      }

      translate([-width/2+motor_edge+m_distance/2, m_distance/2, 0]){
        cylinder(d1=m_hole*2, d2=m_hole, h = wall*1.1, center=true);
      }
      translate([-width/2+motor_edge+m_distance/2, -m_distance/2, 0]){
        cylinder(d1=m_hole*2, d2=m_hole, h = wall*1.1, center=true);
      }
      translate([-width/2+motor_edge-m_distance/2, m_distance/2, 0]){
        cylinder(d1=m_hole*2, d2=m_hole, h = wall*1.1, center=true);
      }
      translate([-width/2+motor_edge-m_distance/2, -m_distance/2, 0]){
        cylinder(d1=m_hole*2, d2=m_hole, h = wall*1.1, center=true);
      }
      
      //Long holes
      translate([(width-m_d2)/2-hole_edge_w, (length-clamp_width)/2-hole_edge_l, 0]){
        translate([m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([-m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([ 0, 0, 0]){
          cube(size=[m_d2, m_d, wall*1.1], center=true);
        }
      }

      translate([(width-m_d2)/2-hole_edge_w-clamp_length, (length-clamp_width)/2-hole_edge_l, 0]){
        translate([m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([-m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([ 0, 0, 0]){
          cube(size=[m_d2, m_d, wall*1.1], center=true);
        }
      }

      translate([(width-m_d2)/2-hole_edge_w, (clamp_width-length)/2+hole_edge_l, 0]){
        translate([m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([-m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([ 0, 0, 0]){
          cube(size=[m_d2, m_d, wall*1.1], center=true);
        }
      }

      translate([(width-m_d2)/2-hole_edge_w-clamp_length, (clamp_width-length)/2+hole_edge_l, 0]){
        translate([m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([-m_d2/2, 0, 0]){
          cylinder(d=m_d, h = wall*1.1, center=true);
        }
        translate([ 0, 0, 0]){
          cube(size=[m_d2, m_d, wall*1.1], center=true);
        }
      }
    }
  }
    
  
}

module printhead_mount(){
  phm_h = 65;
  phm_w = 75;
  phm_l = 35;
  phm_wall = 2;
  wall_shift = 20;
  lh = 20;
  lh_z = 16;
  lh_x = 30;
  
  ph_x = -1;
  ph_x2 = 1;
  ph_z = 12-25;

  ph_mx = 20;
  ph_mz = 21.5;

/*  
  // Spacers
  translate([(phm_l+phm_wall)/2, 80, phm_h/2]){
    rotate([0,270,0])
    difference(){
      roundedRect([15, 9, 6],5);    
      translate([3, 0, 0])
      cylinder(d=M3_hole, h=20, center=t);
    }
  }
  translate([(phm_l+phm_wall)/2, 80, phm_h/2+17]){
    rotate([0,270,0])
    difference(){
      roundedRect([15, 9, 6],5);    
      translate([3, 0, 0])
      cylinder(d=M3_hole, h=20, center=t);
    }
  }
  translate([(phm_l+phm_wall)/2, 80, phm_h/2-17]){
    rotate([0,270,0])
    difference(){
      roundedRect([15, 9, 6],5);    
      translate([3, 0, 0])
      cylinder(d=M3_hole, h=20, center=t);
    }
  }
*/

  translate([0, 0, phm_h/2]){
    difference(){
      union(){
        translate([0, wall_shift, 0]){
          cube([phm_l, phm_wall, phm_h],t);
        }
        translate([(phm_l-phm_wall)/2, (phm_w-phm_wall)/2, 0]){
          rotate([0,90,0])
          roundedRect([phm_h, phm_w, phm_wall],5,[0,0,1,1]);
        }
        // Enforcement
        for(i=[0:1:1])mirror([0,0,i])
        hull(){
          a = phm_l/2;
          b = wall_shift-wall_shift/2;
          c = (phm_h-phm_wall)/2;
          translate([a, b, c]){
            cube([phm_wall, wall_shift, phm_wall],t);
          }
          translate([0, wall_shift, c]){
            cube([phm_l, phm_wall, phm_wall],t);
          }
        }
      }
      // holes print head mount
      translate([ph_x, 0, ph_z])
      for(i=[0:1:1])mirror([i,0,0]){
        translate([ph_mx/2, phm_w/2, ph_mz/2]){
          rotate([90,0,0]){
            cylinder(d=M3_hole, h=phm_wall*100.1, center=t);
          }
        }
        translate([ph_mx/2, phm_w/2, -ph_mz/2]){
          rotate([90,0,0]){
            cylinder(d=M3_hole, h=phm_wall*100.1, center=t);
          }
        }
      }
      translate([0, ph_x2, ph_z])
      for(i=[0:1:1])mirror([0,0,i]){
        translate([0, ph_mx/2 + phm_w/2, ph_mz/2]){
          rotate([0,90,0]){
            cylinder(d=M3_hole, h=phm_wall*100.1, center=t);
          }
        }
        translate([0, -ph_mx/2 + phm_w/2, ph_mz/2]){
          rotate([0,90,0]){
            cylinder(d=M3_hole, h=phm_wall*100.1, center=t);
          }
        }
      }
      
      // Long holes mount on linear bearing
      hull(){
        translate([phm_l/2, phm_w/2, lh_z+lh/2])
        rotate([0,90,0]){
          cylinder(d=M3_hole, h=phm_wall*1.1, center=t);
        }
        translate([phm_l/2, phm_w/2, lh_z-lh/2])
        rotate([0,90,0]){
          cylinder(d=M3_hole, h=phm_wall*1.1, center=t);
        }
      }
      hull(){
        translate([phm_l/2, phm_w/2+lh_x, lh_z+lh/2])
        rotate([0,90,0]){
          cylinder(d=M3_hole, h=phm_wall*1.1, center=t);
        }
        translate([phm_l/2, phm_w/2+lh_x, lh_z-lh/2])
        rotate([0,90,0]){
          cylinder(d=M3_hole, h=phm_wall*1.1, center=t);
        }
      }
      hull(){
        translate([phm_l/2, phm_w/2-lh_x, lh_z+lh/2])
        rotate([0,90,0]){
          cylinder(d=M3_hole, h=phm_wall*1.1, center=t);
        }
        translate([phm_l/2, phm_w/2-lh_x, lh_z-lh/2])
        rotate([0,90,0]){
          cylinder(d=M3_hole, h=phm_wall*1.1, center=t);
        }
      }
    }
  }
}


module fork(){
  
  f_w = 28;
  f_gap = 20;
  f_gap_l = 30;
  f_h = 19;
  f_l = 50;
  tube_e2 = 15.2;
  
  rotate([90,0,0])translate([0, f_w/2, 0])
  difference(){
    hull(){
      translate([f_l/2, 0, f_h/2])rotate([90,0,0]){
        cylinder(d=f_h, h=f_w, center=t);
      }
      translate([0, 0, f_h/2]){
        cube([f_l,f_w,f_h], t);
      }
    }
    // Cut gap
    hull(){
      translate([(f_l-f_gap_l)/2, 0, f_h/2]){
        cylinder(d=f_gap, h=f_w, center=t);
      }
      translate([(f_gap_l+f_l)/2, 0, f_h/2]){
        cylinder(d=f_gap, h=f_w, center=t);
      }
    }
    // Cut fork screw
    translate([f_l/2, 0, f_h/2])rotate([90,0,0]){
      cylinder(d=M3_hole, h=f_w*1.1, center=t);
      cylinder(d=M3_nut_e, h=f_gap+6, center=t, $fn=6);
    }
    // Cut tube
    translate([23-f_l, 0, f_h/2]){
      cube([f_l,tube_e2,tube_e2], t);
    }
    translate([10-f_l/2, 0, f_h/2])rotate([90,0,0]){
      cylinder(d=M3_hole, h=f_w*1.1, center=t);
    }
    translate([0, 0, f_h/2])rotate([0,90,0]){
      cylinder(d=15, h=f_l*1.1, center=t);
    }
    // Cut half plus 1mm tolerance
    translate([0, f_w/2, f_h/2]){
      cube([f_l*2.1,f_w+1,f_h*1.1], t);
    }
    
  }
  
}



module belt_mount_printhead(){
  bmp_l = 80;
  bmp_w = 40;
  bmp_wall = 2;
  mh_x = 34.5;
  mh_y = 15.4;
  
  loop_x = 9;
  loop_y = -2;
  loop_d = 10;
  loop_d2 = 15;
  loop_h = 7;
  loop_h2 = 3;
  
  clamp_l = 10;
  clamp_w = 15;
  clamp_w2 = 8;
  clamp_h = 10;
  clamp_x = -25;
  clamp_gap = 3;
  
  joint_y = -35;
  joint_w = 25;
  joint_w2 = 50;
  joint_l = 10;
  joint_l2 = 20;
  joint_h = 35;
  joint_gap = 30;
  
  
  
  
  difference(){
    union(){
      //Base plate
      hull(){
        roundedRect([bmp_l, bmp_w, bmp_wall], 5);
        translate([0, joint_y, 0]){
          roundedRect([joint_w2*1.1,joint_l,bmp_wall], 3);
        }
      }
      // Joint
      translate([0, joint_y, bmp_wall]){
        hull(){
          translate([0, 0, joint_h])rotate([-45,0,0]){
            cube([joint_w,0.1,10], t);
          }
          translate([0, 5, 0]){
            roundedRect([joint_w2,joint_l2,0.1], 3);
          }
        }
        translate([0, 0, joint_h])rotate([-45,0,0]){
          hull(){
            translate([0,-20,0]){
              cylinder(d=10,h=joint_l, center=t);
            }
            cube([joint_w,0.1,10], t);
          }
        }
      }
      // Belt mounts
      for(i=[0:1:1])mirror([i,0,0]){
        translate([loop_x, loop_y, bmp_wall+loop_h/2]){
          cylinder(d=loop_d, h=loop_h, center=t);
        }
        translate([loop_x, loop_y, bmp_wall+loop_h+loop_h2/2]){
          cylinder(d1=loop_d, d2=loop_d2, h=loop_h2, center=t);
        }
        translate([clamp_x, loop_y, bmp_wall+clamp_h/2]){
          difference(){
            hull(){
              cube([clamp_l,clamp_w2,clamp_h], t);
              translate([0, 0, -clamp_h/2]){
                cube([clamp_l,clamp_w,0.1], t);
              }
            }
            cube([clamp_l*1.1,clamp_gap,clamp_h*1.1], t);
          }
        }
      }
    }
    translate([0, joint_y, joint_h+bmp_wall])rotate([-45,0,0]){
      translate([0,-20,0]){
        cylinder(d=M3_hole,h=joint_l*1.1, center=t);
      }
    }
    // Mount holes on linear bearing
    for(j=[0:1:1])mirror([0,j,0])
    for(i=[0:1:1])mirror([i,0,0])
    translate([mh_x, mh_y, bmp_wall/2]){
      cylinder(d=M3_hole, h=bmp_wall*1.1, center=t);
    }
  }
}




module cutter_motor_mount(){

  cm_h = 25;
  cm_wall = 2;
  cm_w = 45;
  cm_l = 70;
  cm_shift_y = 15;
  
  bar_shift = -20;
  
  s_shift_x = 12.5;
  s_shift_y = 0;

  long_hole = 5;

  difference(){
    union(){
      roundedRect([cm_l,cm_w,cm_h],5);
    }
    // Bar cut
    translate([bar_shift, 0, cm_h/2]){
      rotate([0, 45, 0]){
        cube(size=[bar_e2, cm_w*1.1, bar_e2], center=true);
      }
    }
    // Bar mount hole
    translate([bar_shift, 0, cm_h/2]){
      cylinder(d=M3_hole, h=cm_h*1.1, center=true);
    }
    translate([bar_shift, 0, cm_h]){
      cylinder(d=M3_nut_e, h=3, center=true, $fn=6);
    }
    
    // Motor holes
    translate([s_shift_x, s_shift_y, cm_h/2]){
      translate([0, 0, cm_wall]){
        hull(){
          cylinder(d=stepper_hole, h = cm_h, center=true);
          translate([0,50,0]){
            cylinder(d=stepper_hole, h = cm_h, center=true);
          }
        }
      }
      hull(){
        translate([0,-long_hole/2,0]){
          cylinder(d=stepper_hole, h = cm_h*1.1, center=true);
        }
        translate([0,long_hole/2,0]){
          cylinder(d=stepper_hole, h = cm_h*1.1, center=true);
        }
      }
      translate([stepper_mount/2, stepper_mount/2, 0]){
        hull(){
          translate([0,-long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
          translate([0,long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
        }
      }
      translate([-stepper_mount/2, stepper_mount/2, 0]){
        hull(){
          translate([0,-long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
          translate([0,long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
        }
      }
      translate([-stepper_mount/2, -stepper_mount/2, 0]){
        hull(){
          translate([0,-long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
          translate([0,long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
        }
      }
      translate([stepper_mount/2, -stepper_mount/2, 0]){
        hull(){
          translate([0,-long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
          translate([0,long_hole/2,0]){
            cylinder(d=M3_hole, h = cm_h*1.1, center=true);
          }
        }
      }
    }
  }
  
}

module cutter_belt_mount(){

  cm_h = 25;
  cm_wall = 2;
  cm_w = 40;
  cm_l = 70;
  cm_shift_y = 15;
  
  bar_shift = -20;
  
  s_shift_x = 12.5;
  s_shift_y = 0;

  long_hole = 5;

  difference(){
    union(){
      roundedRect([cm_l,cm_w,cm_h],5);
    }
    // Bar cut
    translate([bar_shift, 0, cm_h/2]){
      rotate([0, 45, 0]){
        cube(size=[bar_e2, cm_w*1.1, bar_e2], center=true);
      }
    }
    // Bar mount hole
    translate([bar_shift, 0, cm_h/2]){
      cylinder(d=M3_hole, h=cm_h*1.1, center=true);
    }
    translate([bar_shift, 0, cm_h]){
      cylinder(d=M3_nut_e, h=3, center=true, $fn=6);
    }
    
    // Bearing holes
    translate([s_shift_x, s_shift_y, cm_h/2]){
      translate([0, 0, cm_wall]){
        difference(){
          hull(){
            cylinder(d=stepper_hole-5, h = cm_h, center=true);
            translate([0,-50,0]){
              cylinder(d=stepper_hole-5, h = cm_h, center=true);
            }
          }
          translate([0,0,(bb5_h-cm_h)/2]){
            cylinder(d=bb5_do+2*cm_wall, h = bb5_h, center=true);
          }
        }
      }
      translate([0,0,bb5_h+(cm_wall-cm_h)/2-0.1]){
        cylinder(d1=bb5_do, d2=bb5_do-5, h = cm_wall+0.1, center=true);
      }      
      translate([0,0,(bb5_h-cm_h)/2-0.1]){
        cylinder(d=bb5_do, h = bb5_h, center=true);
      }      
      cylinder(d=bb5_do-5, h = cm_h*1.1, center=true);
      // Mount holes
      translate([stepper_mount/2, stepper_mount/2, 0]){
        cylinder(d=M3_hole, h = cm_h*1.1, center=true);
        translate([0, 0, -6]){
          hull(){
            cylinder(d=6, h = cm_h, center=true);
            cylinder(d=M3_hole, h = cm_h+6, center=true);
          }
        }
      }
      translate([-stepper_mount/2, stepper_mount/2, 0]){
        cylinder(d=M3_hole, h = cm_h*1.1, center=true);
        translate([0, 0, -6]){
          hull(){
            cylinder(d=6, h = cm_h, center=true);
            cylinder(d=M3_hole, h = cm_h+6, center=true);
          }
        }
      }
      translate([-stepper_mount/2, -stepper_mount/2, 0]){
        cylinder(d=M3_hole, h = cm_h*1.1, center=true);
        translate([0, 0, -6]){
          hull(){
            cylinder(d=6, h = cm_h, center=true);
            cylinder(d=M3_hole, h = cm_h+6, center=true);
          }
        }
      }
      translate([stepper_mount/2, -stepper_mount/2, 0]){
        cylinder(d=M3_hole, h = cm_h*1.1, center=true);
        translate([0, 0, -6]){
          hull(){
            cylinder(d=6, h = cm_h, center=true);
            cylinder(d=M3_hole, h = cm_h+6, center=true);
          }
        }
      }
    }
  }

  // Top bearing mount
  tbm_l = 40;
  tbm_h = bb5_h + 2;
  translate([0, 41, 0])
  difference(){
    union(){
      roundedRect([tbm_l,cm_w,tbm_h],5);
    }
    // Bearing holes
    translate([0,0,tbm_h-bb5_h/2+0.1]){
      cylinder(d=bb5_do, h = bb5_h, center=true);
    }      
    translate([0,0,(bb5_h-cm_h)/2-0.1]){
      cylinder(d=bb5_do-5, h = bb5_h, center=true);
    }      
    cylinder(d=bb5_do-5, h = cm_h*1.1, center=true);
    
    // Mount holes
    translate([stepper_mount/2, stepper_mount/2, 0]){
      cylinder(d=M3_hole, h = cm_h*1.1, center=true);
      translate([0, 0, cm_wall+tbm_h/2]){
        cylinder(d=M3_nut_e, h = tbm_h, center=true, $fn=6);
      }
    }
    translate([-stepper_mount/2, stepper_mount/2, 0]){
      cylinder(d=M3_hole, h = cm_h*1.1, center=true);
      translate([0, 0, cm_wall+tbm_h/2]){
        cylinder(d=M3_nut_e, h = tbm_h, center=true, $fn=6);
      }
    }
    translate([-stepper_mount/2, -stepper_mount/2, 0]){
      cylinder(d=M3_hole, h = cm_h*1.1, center=true);
      translate([0, 0, cm_wall+tbm_h/2]){
        cylinder(d=M3_nut_e, h = tbm_h, center=true, $fn=6);
      }
    }
    translate([stepper_mount/2, -stepper_mount/2, 0]){
      cylinder(d=M3_hole, h = cm_h*1.1, center=true);
      translate([0, 0, cm_wall+tbm_h/2]){
        cylinder(d=M3_nut_e, h = tbm_h, center=true, $fn=6);
      }
    }
  }
  
}

module cutter_guide_bar(){
  cgb_l = 200;
  cgb_w = sqrt(2*bar_e*bar_e);
  cgb_w2 = cgb_w + 20;
  cgb_h = 17;
  cgb_wall = 2;
  
  brim_h = 0.35;
  
  translate([0, 0, cgb_h/2]){
    difference(){
      union(){
        cube(size=[cgb_l, cgb_w, cgb_h], center=true);
        translate([0, 0, (cgb_wall-cgb_h)/2]){
          cube(size=[cgb_l, cgb_w2, cgb_wall], center=true);
        }
        // Brim
        for(i=[0:1:1])mirror([0,i,0]){
          translate([cgb_l/2, cgb_w2/2, (brim_h-cgb_h)/2]){
            cylinder(d=15, h=brim_h, center=true);
          }
          translate([-cgb_l/2, cgb_w2/2, (brim_h-cgb_h)/2]){
            cylinder(d=15, h=brim_h, center=true);
          }
        }
      }
      // Cut grove
      translate([0, 0, cgb_h/2]){
        rotate([45, 0, 0])
        cube(size=[cgb_l*1.1, bar_e, bar_e], center=true);
      }
      // Cut tips
      translate([0, 0, (cgb_h+bar_e)/2-3]){
        cube(size=[cgb_l*1.1, bar_e*2.1, bar_e], center=true);
      }
      for(i=[0:1:4])
      translate([(cgb_l/2-10)-i*(cgb_l/2-10)/2*2, 0, 0]){
        translate([0, 0, 0]){
          cylinder(d=M3_hole, h=cgb_h*1.1, center=true);
        }
        translate([0, 0, 1.5-cgb_h/2]){
          cylinder(d=M3_nut_e, h=3.1, center=true, $fn=6);
        }
        translate([0, 0, 3+1.5-cgb_h/2]){
          cylinder(d1=M3_nut_e, d2=M3_hole, h=3, center=true, $fn=6);
        }
      }
    }
  }
}


module cutter_guide(){
  cg_w = 15;
  cg_l = 85;
  cg_b = 5;
  cg_h = 15;
  cg_wall = 2;
  mount_w = 12;
  mount_l = 62;
  mount_h = 5;
  
  hole_l = 10;
  

  difference(){
    union(){
      // Body
      translate([0, 0, cg_b/2]){
        cube(size=[cg_l, cg_w, cg_b], center=true);
      }
      translate([0, -(cg_w-cg_wall)/2, cg_h/2]){
        cube(size=[cg_l, cg_wall, cg_h], center=true);
      }
      // Mounts
      for(i=[0:1:1])mirror([i,0,0])
      difference(){
        hull(){
          translate([(cg_l - mount_w)/2, 0, mount_h/2]){
            cylinder(d=mount_w, h=mount_h, center=true);
          }
          translate([(cg_l - mount_w)/2, mount_l, mount_h/2]){
            cylinder(d=mount_w, h=mount_h, center=true);
          }
        }
        translate([(cg_l - mount_w)/2, mount_l, mount_h/2]){
          hull(){
            cylinder(d=M3_hole, h=mount_h*1.1, center=true);
            translate([0, -hole_l, 0]){
              cylinder(d=M3_hole, h=mount_h*1.1, center=true);
            }
          }
        }        
        translate([(cg_l - mount_w)/2, mount_l-25, mount_h/2]){
          hull(){
            cylinder(d=M3_hole, h=mount_h*1.1, center=true);
            translate([0, -hole_l, 0]){
              cylinder(d=M3_hole, h=mount_h*1.1, center=true);
            }
          }
        }        
      }
    }

    // Mounts
    for(i=[0:1:1])mirror([i,0,0]){
      translate([(cg_l - mount_w)/2, mount_l, mount_h/2]){
        hull(){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
          translate([0, -hole_l, 0]){
            cylinder(d=M3_hole, h=mount_h*1.1, center=true);
          }
        }
      }        
      translate([(cg_l - mount_w)/2, mount_l-25, mount_h/2]){
        hull(){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
          translate([0, -hole_l, 0]){
            cylinder(d=M3_hole, h=mount_h*1.1, center=true);
          }
        }
      }
    }

    
    translate([cg_l/2, 0, cg_h*1.5-1]){
      rotate([0, 5, 0]){
        cube(size=[cg_l, cg_w*1.1, cg_h], center=true);
      }
    }
    translate([-cg_l/2, 0, cg_h*1.5-6.5]){
      rotate([0, -10, 0]){
        cube(size=[cg_l, cg_w*1.1, cg_h], center=true);
      }
    }
    
    
  }

}



module linear_bearing_cutter_bottom(){
  lbcb_w = 40;
  lbcb_l = 85;
  lbcb_b = 3;
  mount_w = 12;
  mount_l = 90;
  mount_h = 19;
  bb_gap = 40;
  bb6_do = 19;
  bb6_H = 6;
  bb_drill = 5.5;
  
  cube_edge = sqrt(lbcb_w * lbcb_w / 2);

  show_bearings = 0;
  if(show_bearings == 1){
    translate([0, 0, 28])rotate([45, 0, 0]){
      cube(size=[100, 15, 15], center=true);
    }
    translate([0, 0, lbcb_b]){
      for(i=[0:1:1])mirror([0,i,0])
      rotate([45, 0, 0]){
        translate([bb_gap/2, 0, 0]){
          translate([0, 0, 18]){
            difference(){
              cylinder(h = bb6_H, r = bb6_do / 2, center=t);      
              cylinder(h = 100, r = bb_drill / 2, center=t);
            }
          }
        }
      }
    }
  }

  handle_w = 30;
  handle_l = 12;
  handle_h = 7;
  for(i=[0:1:1])mirror([i,0,0])translate([50, 0, 0]){
    difference(){
      roundedRect([handle_l, handle_w, handle_h], 3, [0,1,0,1]);
      // Center cut
      translate([0, 0, handle_h/2]){
        difference(){
          cube(size=[handle_l*1.1, 10, handle_h*1.1], center=true);
          translate([1, 0, 0]){
            rotate([90, 0, 0]){
              cylinder(d=handle_h*1.2, h=10, center=true);
            }
            translate([handle_l/2, 0, 0]){
              cube(size=[handle_l, 10, handle_h*1.1], center=true);
            }
          }
        }
      }
      
      //Mount screw cuts
      translate([0, 10, handle_h/2]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=handle_l*1.1, center=true);
        }
      }
      translate([0, -10, handle_h/2]){
        rotate([0, 90, 0]){
          cylinder(d=M3_hole, h=handle_l*1.1, center=true);
        }
      }
    }
  }


  difference(){
    union(){
      // Body
      translate([0, 0, lbcb_b]){
        rotate([45, 0, 0]){
          cube(size=[lbcb_l, cube_edge, cube_edge], center=true);
        }
      }
      translate([0, 0, lbcb_b/2]){
        cube(size=[lbcb_l, lbcb_w, lbcb_b], center=true);
      }
      // Spacers
      translate([0, 0, lbcb_b]){
        for(i=[0:1:1])mirror([0,i,0])
        rotate([45, 0, 0]){
          translate([bb_gap/2, 0, 0]){
            cylinder(d=10, h=cube_edge+2, center=true);
          }
          cylinder(d=10, h=cube_edge+2, center=true);
          translate([-bb_gap/2, 0, 0]){
            cylinder(d=10, h=cube_edge+2, center=true);
          }
        }
      }
      // Mounts
      for(i=[0:1:1])mirror([i,0,0])
      difference(){
        hull(){
          translate([(lbcb_l - mount_w)/2, 0, mount_h/2]){
            cylinder(d=mount_w, h=mount_h, center=true);
          }
          translate([(lbcb_l - mount_w)/2, mount_l, mount_h/2]){
            cylinder(d=mount_w, h=mount_h, center=true);
          }
        }
        translate([(lbcb_l - mount_w)/2, mount_l, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
        translate([(lbcb_l - mount_w)/2, mount_l-25, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
        translate([(lbcb_l - mount_w)/2, mount_l-32.5, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
        translate([(lbcb_l - mount_w)/2, mount_l-40, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
      }
    }
    // Ball bearing holes
    translate([0, 0, lbcb_b]){
      for(i=[0:1:1])mirror([0,i,0])
      rotate([45, 0, 0]){
        translate([bb_gap/2, 0, 0]){
          cylinder(d=bb_drill, h=cube_edge*2.1, center=true);
        }
        cylinder(d=bb_drill, h=cube_edge*2.1, center=true);
        translate([-bb_gap/2, 0, 0]){
          cylinder(d=bb_drill, h=cube_edge*2.1, center=true);
        }
      }
    }
    
    // Base cut
    translate([0, 0, -10]){
      cube(size=[lbcb_l*1.1, lbcb_w*1.1, 20], center=true);
    }
    // Tip cut
    translate([0, 0, mount_h+3]){
      rotate([45, 0, 0])
      cube(size=[lbcb_l*1.1, bar_e, bar_e], center=true);
    }
    // Belt mount cuts
    for(j=[0:1:1])mirror([0,j,0]){
      for(i=[0:1:1])mirror([i,0,0]){
        translate([lbcb_l/2, 10, 5]){
          rotate([0, 90, 0]){
            cylinder(d=M3_hole, h=40, center=true);
          }
        }
        translate([lbcb_l/2-5, 10, 7]){
          rotate([0, 90, 0]){
            cylinder(d=6, h=4, center=true);
          }
        }
        translate([lbcb_l/2-5, 10, 0]){
          cube(size=[4, 6, 14.5], center=true);
        }
      }
    }
    
  }

}

module linear_bearing_cutter_top(){
  lbct_w = 30;
  lbct_l = 85;
  lbct_h = 20;

  mount_w = 12;
  mount_l = 90;
  mount_h = lbct_h;

  bb_gap = 40;
  bb6_do = 19;
  bb6_H = 6;
  bb_drill = 5.5;
  bb_shift_y = 2.5;
  
  bb_gap_w = 2*bb6_H+5;

  blade_gap = 13;
  
  blade_axis_z = 35;
  blade_axis_x = -5;
  blade_axis_w = 7;

  difference(){
    union(){
      // Body
      translate([0, 0, lbct_h/2]){
        cube(size=[lbct_l, lbct_w, lbct_h], center=true);
      }
      // Mounts
      for(i=[0:1:1])mirror([i,0,0])
      difference(){
        hull(){
          translate([(lbct_l - mount_w)/2, 0, mount_h/2]){
            cylinder(d=mount_w, h=mount_h, center=true);
          }
          translate([(lbct_l - mount_w)/2, mount_l, mount_h/2]){
            cylinder(d=mount_w, h=mount_h, center=true);
          }
        }
        translate([(lbct_l - mount_w)/2, mount_l, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
        translate([(lbct_l - mount_w)/2, mount_l-25, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
        translate([(lbct_l - mount_w)/2, mount_l-32.5, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
        translate([(lbct_l - mount_w)/2, mount_l-40, mount_h/2]){
          cylinder(d=M3_hole, h=mount_h*1.1, center=true);
        }        
      }
    blade_gap = 13;

    }
    // Blade axis
    translate([blade_axis_x, 0, blade_axis_z]){
      rotate([90, 0, 0])
      cylinder(d=M3_hole, h=lbct_w*1.1, center=true);
    }
/*    
    // Cutter blade holes
    translate([5, 0, 5]){
      rotate([0, -45, 0]){
        rotate([90, 0, 0]){
          cylinder(d=M3_hole, h=lbct_w*1.1, center=true);
          translate([0, 0, -lbct_w/2]){
            cylinder(d=M3_nut_e, h=6, center=true, $fn=6);
          }
        }
        translate([0, 0, blade_gap]){
          rotate([90, 0, 0]){
            cylinder(d=M3_hole, h=lbct_w*1.1, center=true);
            translate([0, 0, -lbct_w/2]){
              cylinder(d=M3_nut_e, h=6, center=true, $fn=6);
            }
          }
        }
      }
    }
*/    
    
    // Ball bearing hole(s)
    translate([0, 0, lbct_h/2]){
      for(i=[0:1:1])mirror([i,0,0]){
        translate([bb_gap/2, bb_shift_y, 0]){
          cube(size=[bb6_do + 4, bb_gap_w, lbct_h*1.1], center=true);
        }
        translate([bb_gap/2, 0, -2.5]){
          rotate([90, 0, 0]){
            cylinder(d=bb_drill, h=lbct_w*1.1, center=true);
            translate([0, 0, 2.5])rotate([0, 0, 30])
            cylinder(d=M6_nut_e, h=bb_gap_w, center=true, $fn=6);
          }
        }
      }
    }
  }

}

module blade_mount(bm_h = 8){
  
  b_w = 25;
  b_l = 55;
  b_angle = 7;
  b_distance = 10;
  b_gap = 12;
  
  bm_l = 60;
  bm_w = 55;
  bm_wall = 5;
  bm_hole_gap = 13;
  bm_shift_x = 1;
  bm_shift_y = -3;


  // top plate
  translate([1, -16+11, bm_wall/2+0*(bm_h + 1.7)]){
    difference(){
      rotate([0, 0, b_angle]){
        difference(){
          hull(){
            cube(size=[42,14.5,bm_wall], center=true);
            translate([bm_hole_gap, -4, 5-bm_wall/2]){
              cylinder(d=6, h = 10, center=t);
            }
            translate([0, -4, 5-bm_wall/2]){
              cylinder(d=6, h = 10, center=t);
            }
          }
          translate([bm_hole_gap, -4, 0]){
            cylinder(d=M3_hole, h = 20, center=t);
          }
          translate([0, -4, 0]){
            cylinder(d=M3_hole, h = 20, center=t);
          }
        }
      }
      translate([0, -11.5, 0]){
        cube(size=[bm_l*1.1, 5, 20], center=true);
      }
    }
  }
  
  
  difference(){
      translate([0, b_distance, 0])
      rotate([0, 0, b_angle]){
        difference(){
            difference(){
              roundedRect([b_l, b_w, bm_h],5,[0,0,1,1]);
              translate([bm_shift_x, bm_shift_y, bm_h]){
                cube(size=[44,23,2], center=true);
              }
            }
          translate([0, -b_w/2, bm_h/2]){
            cube(size=[b_l*2, b_gap, bm_h*1.1], center=true);
          }
          translate([bm_shift_x, bm_shift_y, bm_h/2]){
            translate([bm_hole_gap, 0, 0]){
                cylinder(d=M3_hole, h = bm_h*1.1, center=true);
                translate([0, 0, -5.5]){
                  cylinder(d=M3_nut_e, h = bm_h, center=true, $fn=6);
                }
                translate([0, 0, bm_h/2-4.05]){
                  cylinder(d1=M3_nut_e, d2=M3_hole, h=3, center=t, $fn=6);
                }
            }
            translate([-bm_hole_gap*0, 0, 0]){
                cylinder(d=M3_hole, h = bm_h*1.1, center=true);
                translate([0, 0, -5.5]){
                  cylinder(d=M3_nut_e, h = bm_h, center=true, $fn=6);
                }
                translate([0, 0, bm_h/2-4.05]){
                  cylinder(d1=M3_nut_e, d2=M3_hole, h=3, center=t, $fn=6);
                }
            }
          }
        }
      }
    translate([0, -1, bm_h/2]){
      cube(size=[bm_l*1.1, 5, bm_h*1.1], center=true);
    }
  }

  
}







module gear(teeth = 10, h = 5, shaft = M3_hole){
  mod = 3; 
  alpha = 180/teeth;
  r1 = mod*teeth/(2*3.14159);
  r=(mod/2)/tan(alpha);
  edge = 1;
  
  difference(){
    union(){
      x1=r;
      y1=mod/2;
      x2=r+mod;
      y2=0;
      x3=r;
      y3=-mod/2;
      x4=0;
      y4=0;
      translate([0, 0, edge]){
        linear_extrude(height=h-edge){
          for(i=[0:1:teeth]){
            rotate([0, 0, i*360/teeth]){
              polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4]]);
            }
          }
        }
      }
      translate([0, 0, edge]){
        mirror([0, 0, 1]){
          linear_extrude(height=edge, scale=[0.985, 0.985]){
            for(i=[0:1:teeth]){
              rotate([0, 0, i*360/teeth]){
                polygon(points=[[x1,y1],[x2,y2],[x3,y3],[x4,y4]]);
              }
            }
          }
        }
      }
    }
    translate([0, 0, h/2]){
      cylinder(d=shaft, h=h*1.1, center=true);
    }
    if(shaft==-1){
      translate([0, 0, h/2]){
        difference(){
          cylinder(d=motor_shaft, h=h*1.1, center=true);
          translate([0, motor_shaft_shift, 0]){
            cube(size=[motor_shaft, motor_shaft, 16], center=true);
          }
        }
      }
    }
  }
  
}


module roundedRect(size, radius, edges=[1, 1, 1, 1]){
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z){
    hull(){
        // place 4 circles in the corners, with the given radius
        if(edges[0]){
          translate([(-x/2)+(radius), (-y/2)+(radius), 0])
          circle(r=radius);
        }
        else{
          translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
          square(size=[radius, radius], center=true);
        }
        if(edges[1]){
          translate([(x/2)-(radius), (-y/2)+(radius), 0])
          circle(r=radius);
        }
        else{
          translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
          square(size=[radius, radius], center=true);
        }

        if(edges[2]){
          translate([(-x/2)+(radius), (y/2)-(radius), 0])
          circle(r=radius);
        }
        else{
          translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
          square(size=[radius, radius], center=true);
        }

        if(edges[3]){
          translate([(x/2)-(radius), (y/2)-(radius), 0])
          circle(r=radius);
        }
        else{
          translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
          square(size=[radius, radius], center=true);
        }
    }
  }
}
