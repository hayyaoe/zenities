const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c0c11", /* black   */
  [1] = "#4C5C71", /* red     */
  [2] = "#3F5882", /* green   */
  [3] = "#5D7189", /* yellow  */
  [4] = "#75899C", /* blue    */
  [5] = "#97A6AF", /* magenta */
  [6] = "#B2C1C6", /* cyan    */
  [7] = "#e0e1de", /* white   */

  /* 8 bright colors */
  [8]  = "#9c9d9b",  /* black   */
  [9]  = "#4C5C71",  /* red     */
  [10] = "#3F5882", /* green   */
  [11] = "#5D7189", /* yellow  */
  [12] = "#75899C", /* blue    */
  [13] = "#97A6AF", /* magenta */
  [14] = "#B2C1C6", /* cyan    */
  [15] = "#e0e1de", /* white   */

  /* special colors */
  [256] = "#0c0c11", /* background */
  [257] = "#e0e1de", /* foreground */
  [258] = "#e0e1de",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
