const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#231b30", /* black   */
  [1] = "#3FADC6", /* red     */
  [2] = "#3698F3", /* green   */
  [3] = "#E0AEBE", /* yellow  */
  [4] = "#9FCBBB", /* blue    */
  [5] = "#A2D1D7", /* magenta */
  [6] = "#99FEF6", /* cyan    */
  [7] = "#d3f2ef", /* white   */

  /* 8 bright colors */
  [8]  = "#93a9a7",  /* black   */
  [9]  = "#3FADC6",  /* red     */
  [10] = "#3698F3", /* green   */
  [11] = "#E0AEBE", /* yellow  */
  [12] = "#9FCBBB", /* blue    */
  [13] = "#A2D1D7", /* magenta */
  [14] = "#99FEF6", /* cyan    */
  [15] = "#d3f2ef", /* white   */

  /* special colors */
  [256] = "#231b30", /* background */
  [257] = "#d3f2ef", /* foreground */
  [258] = "#d3f2ef",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
