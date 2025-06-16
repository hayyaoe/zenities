const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0a090a", /* black   */
  [1] = "#957560", /* red     */
  [2] = "#3E838B", /* green   */
  [3] = "#498C95", /* yellow  */
  [4] = "#60969B", /* blue    */
  [5] = "#7AA4A2", /* magenta */
  [6] = "#9FAEAB", /* cyan    */
  [7] = "#f0d8c6", /* white   */

  /* 8 bright colors */
  [8]  = "#a8978a",  /* black   */
  [9]  = "#957560",  /* red     */
  [10] = "#3E838B", /* green   */
  [11] = "#498C95", /* yellow  */
  [12] = "#60969B", /* blue    */
  [13] = "#7AA4A2", /* magenta */
  [14] = "#9FAEAB", /* cyan    */
  [15] = "#f0d8c6", /* white   */

  /* special colors */
  [256] = "#0a090a", /* background */
  [257] = "#f0d8c6", /* foreground */
  [258] = "#f0d8c6",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
