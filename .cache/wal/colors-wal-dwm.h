static const char norm_fg[] = "#efe5e4";
static const char norm_bg[] = "#180f14";
static const char norm_border[] = "#a7a09f";

static const char sel_fg[] = "#efe5e4";
static const char sel_bg[] = "#AF9295";
static const char sel_border[] = "#efe5e4";

static const char urg_fg[] = "#efe5e4";
static const char urg_bg[] = "#AA7489";
static const char urg_border[] = "#AA7489";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
