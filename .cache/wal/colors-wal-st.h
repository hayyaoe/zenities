const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c0c0b", /* black   */
  [1] = "#906C2B", /* red     */
  [2] = "#C5773E", /* green   */
  [3] = "#967251", /* yellow  */
  [4] = "#7A8458", /* blue    */
  [5] = "#A99228", /* magenta */
  [6] = "#A39263", /* cyan    */
  [7] = "#e2d099", /* white   */

  /* 8 bright colors */
  [8]  = "#9e916b",  /* black   */
  [9]  = "#906C2B",  /* red     */
  [10] = "#C5773E", /* green   */
  [11] = "#967251", /* yellow  */
  [12] = "#7A8458", /* blue    */
  [13] = "#A99228", /* magenta */
  [14] = "#A39263", /* cyan    */
  [15] = "#e2d099", /* white   */

  /* special colors */
  [256] = "#0c0c0b", /* background */
  [257] = "#e2d099", /* foreground */
  [258] = "#e2d099",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
