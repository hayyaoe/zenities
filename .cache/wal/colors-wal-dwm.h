static const char norm_fg[] = "#c0cbc4";
static const char norm_bg[] = "#091927";
static const char norm_border[] = "#868e89";

static const char sel_fg[] = "#c0cbc4";
static const char sel_bg[] = "#AB8C79";
static const char sel_border[] = "#c0cbc4";

static const char urg_fg[] = "#c0cbc4";
static const char urg_bg[] = "#A4584E";
static const char urg_border[] = "#A4584E";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
