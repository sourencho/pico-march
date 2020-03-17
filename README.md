# pico-march
Raymarching on [PICO-8](https://www.lexaloffle.com/pico-8.php)?
- Frames are pre-buffered and then played back once they're all ready.
- Max number of frames is ~14 before memory runs out.

_Octahedron rotating over 8 frames_

![picomarch.gif](picomarch.gif)

## Todo
- [ ] Make parameters work for arbitrary shapes.
  - There are currently some hardcoded values in there that work well for the octohedron.
- [ ] Create vector 3 class.
- [ ] Makeing loading screen nicer since it takes so long.
- [ ] Optimize.
