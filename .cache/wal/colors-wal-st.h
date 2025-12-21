const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0d0c09", /* black   */
  [1] = "#605D46", /* red     */
  [2] = "#6D694B", /* green   */
  [3] = "#86774E", /* yellow  */
  [4] = "#7E8273", /* blue    */
  [5] = "#9B946A", /* magenta */
  [6] = "#C0B06D", /* cyan    */
  [7] = "#d3d0bd", /* white   */

  /* 8 bright colors */
  [8]  = "#939184",  /* black   */
  [9]  = "#605D46",  /* red     */
  [10] = "#6D694B", /* green   */
  [11] = "#86774E", /* yellow  */
  [12] = "#7E8273", /* blue    */
  [13] = "#9B946A", /* magenta */
  [14] = "#C0B06D", /* cyan    */
  [15] = "#d3d0bd", /* white   */

  /* special colors */
  [256] = "#0d0c09", /* background */
  [257] = "#d3d0bd", /* foreground */
  [258] = "#d3d0bd",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
