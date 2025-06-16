const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#180f14", /* black   */
  [1] = "#AA7489", /* red     */
  [2] = "#AF9295", /* green   */
  [3] = "#D5A8AC", /* yellow  */
  [4] = "#E4C7B4", /* blue    */
  [5] = "#E5B9C6", /* magenta */
  [6] = "#FECDCE", /* cyan    */
  [7] = "#efe5e4", /* white   */

  /* 8 bright colors */
  [8]  = "#a7a09f",  /* black   */
  [9]  = "#AA7489",  /* red     */
  [10] = "#AF9295", /* green   */
  [11] = "#D5A8AC", /* yellow  */
  [12] = "#E4C7B4", /* blue    */
  [13] = "#E5B9C6", /* magenta */
  [14] = "#FECDCE", /* cyan    */
  [15] = "#efe5e4", /* white   */

  /* special colors */
  [256] = "#180f14", /* background */
  [257] = "#efe5e4", /* foreground */
  [258] = "#efe5e4",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
