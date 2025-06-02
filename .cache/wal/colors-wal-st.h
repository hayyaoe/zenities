const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#091927", /* black   */
  [1] = "#A4584E", /* red     */
  [2] = "#AB8C79", /* green   */
  [3] = "#597A85", /* yellow  */
  [4] = "#3BA995", /* blue    */
  [5] = "#4FAD9B", /* magenta */
  [6] = "#B29885", /* cyan    */
  [7] = "#c0cbc4", /* white   */

  /* 8 bright colors */
  [8]  = "#868e89",  /* black   */
  [9]  = "#A4584E",  /* red     */
  [10] = "#AB8C79", /* green   */
  [11] = "#597A85", /* yellow  */
  [12] = "#3BA995", /* blue    */
  [13] = "#4FAD9B", /* magenta */
  [14] = "#B29885", /* cyan    */
  [15] = "#c0cbc4", /* white   */

  /* special colors */
  [256] = "#091927", /* background */
  [257] = "#c0cbc4", /* foreground */
  [258] = "#c0cbc4",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
