static const char norm_fg[] = "#e0e1de";
static const char norm_bg[] = "#0c0c11";
static const char norm_border[] = "#9c9d9b";

static const char sel_fg[] = "#e0e1de";
static const char sel_bg[] = "#3F5882";
static const char sel_border[] = "#e0e1de";

static const char urg_fg[] = "#e0e1de";
static const char urg_bg[] = "#4C5C71";
static const char urg_border[] = "#4C5C71";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
