#pragma once

#include "common.h"

//use degrees
extern f64 cos(f64 x);
extern f64 sin(f64 x);
extern f64 tan(f64 x);
extern f64 atan(f64 x);
extern f64 atan2(f64 x, f64 y); //this implementation is broken? it doesn't work 50% of the time
extern f64 acos(f64 x);

extern f64 rd_atan2(f64 x, f64 y);

extern f64 pow(f64 x, f64 y);
extern f64 sqrt(f64 x);

