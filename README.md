# Toggle 2.0 — Glassmorphic Flutter Toggle with Snake Animation

[![Releases](https://img.shields.io/github/v/release/patrimpj/toggle-2.0?label=Releases&color=brightgreen)](https://github.com/patrimpj/toggle-2.0/releases)

https://github.com/patrimpj/toggle-2.0/releases

A glassmorphic toggle switch widget for Flutter that blends rounded design, zoom effects, a draggable handle, and a snake-like animation. Use it in modern, fluid UIs where motion and clarity matter.

Badges
- Platform: Flutter
- Topics: flutter • flutter-ui • flutter-widget • toggle

Screenshots & demo GIFs
- Live demo GIF (concept): https://media.giphy.com/media/3o6Zt481isNVuQI1l6/giphy.gif
- Glass mockup (static): https://images.unsplash.com/photo-1526378724501-1f36f2f57b93?auto=format&fit=crop&w=800&q=60

Table of contents
- Features
- Quick install
- How to use
- API reference
- Customization guide
- Animation internals
- Performance tips
- Accessibility
- Screenshots and usage scenarios
- Release downloads
- Contributing
- License

Features
- Glassmorphic visual: frosted background, soft blur, subtle border.
- Snake-like animated track: the toggle moves like a narrow ribbon across the track.
- Zoom effect: the handle scales when active or during drag.
- Draggable handle: move the handle by dragging or tap to toggle.
- Rounded design: soft corners and smooth shadows.
- Theme-aware: adapt colors to light and dark themes.
- Lightweight: built for low overhead in rendering and animation.
- Widget-first: designed to work as a plug-in Flutter widget.

Quick install

Add the package to your Flutter project as usual:
- If you use pub.dev, add it to your dependencies in pubspec.yaml.
- Or install from a local package or GitHub release.

Download and execute the release file at https://github.com/patrimpj/toggle-2.0/releases. Grab the bundle for your platform, extract it, and run the included setup or add the widget files to your lib folder. The releases page contains the latest builds and packaged source. Follow the release assets and run the provided installation script or include the package files in your project.

Example (conceptual)
- Add the Toggle widget to a simple layout.
- The code below is a conceptual snippet. Replace package names with the actual package name if you install from pub.dev or from releases.

Use in a widget tree
- Place the toggle inside a stateful widget.
- Update the state on change.

Usage
- Instantiate Toggle2 widget with a bound boolean value.
- Provide onChanged callback to react to state changes.
- Provide optional parameters: activeColor, inactiveColor, width, height, handleSize, borderRadius, animationDuration.

Example properties (conceptual)
- value: bool
- onChanged: ValueChanged<bool>
- activeColor: Color
- inactiveColor: Color
- width: double
- height: double
- handleSize: double
- borderRadius: double
- snakeAnimation: bool
- draggable: bool
- blurSigma: double

API reference (short)
- Toggle2(value, onChanged,
  activeColor: Colors.green,
  inactiveColor: Colors.grey.shade300,
  width: 120,
  height: 44,
  handleSize: 38,
  borderRadius: 24,
  snakeAnimation: true,
  draggable: true,
  blurSigma: 8.0
)

Property guide
- value: current boolean state.
- onChanged: callback invoked with new state.
- activeColor: handle/track color when true.
- inactiveColor: handle/track color when false.
- width / height: overall widget size.
- handleSize: diameter of the draggable knob.
- borderRadius: curve of the background.
- snakeAnimation: enable the ribbon-style track animation.
- draggable: allow the user to drag the handle.
- blurSigma: glass blur intensity (for glassmorphic effect).

Customization guide

Style
- Colors: use Theme.of(context).primaryColor for activeColor to match your app.
- Shadows: reduce elevation on low-power devices to save GPU.
- Glass blur: set blurSigma to 0 to disable blur on older devices.

Layout
- Use width and height to create compact or full-size controls.
- Set borderRadius to match your existing UI corners.
- Place the toggle inside a Container with padding to create a touchable area.

Behavior
- Adjust animationDuration for snappier or calmer motion.
- Use onChanged to connect the toggle to a state store or bloc.

Advanced: chained toggles
- You can chain multiple toggles with an AnimatedList or ReorderableListView.
- Set each Toggle2 to listen to a shared model and update accordingly.

Animation internals

Snake-like track
- The snake effect is a gradient ribbon that moves along the track as the handle transitions.
- The ribbon uses a mask with a moving offset and a custom shader-like paint to simulate flow.
- During drag, the ribbon morphs to match the handle position.

Zooming handle
- The handle scales up on press and scales to a medium size during drag.
- The scale uses a spring curve for a natural response.
- The animation uses a single AnimationController to minimize overhead.

Performance
- The widget uses a single AnimationController for combined animations.
- It caches gradient and mask paints instead of re-building each frame.
- Set repaint boundaries around the widget to contain GPU work: wrap in RepaintBoundary.
- On low-end devices, set blurSigma to a small number or 0 to lower GPU load.

Accessibility
- The widget exposes semantic labels automatically.
- Provide a custom semanticLabel if needed: semanticLabel: 'Airplane mode toggle'.
- Support for keyboard: implement FocusableActionDetector and handle key events for Space/Enter.
- Ensure tap target meets 48x48 dp guideline by wrapping the toggle in a SizedBox or GestureDetector with padding.

Screenshots and scenarios

Dashboard
- Use Toggle2 for quick status toggles on dashboards. Use a slim width for compact rows.

Settings page
- Use Toggle2 with labels to control features. The glassmorphic style fits modern settings pages.

Smart home controls
- Use the snake animation to show motion: on toggling a fan or light, the ribbon can imply flow.

Mobile form
- Use the draggable handle to change user preferences with tactile motion.

Design tips
- For glassmorphism, pick a semi-transparent background and a light border.
- Match handle color to the accent color for clear state recognition.
- Use subtle shadows for depth without heavy contrast.

Release downloads

Important: Download and execute the release file at the releases page:
https://github.com/patrimpj/toggle-2.0/releases

Steps
1. Open the releases page above.
2. Download the release archive or installer asset for your platform.
3. Extract the archive.
4. Run the included setup file or add the package source files to your Flutter project. For example, copy the lib/toggle2 folder into your project's lib folder. If the release includes an install script, run it.

If the link above does not work for any reason, check the Releases section of this repository.

Topics and keywords
- flutter
- flutter-app
- flutter-plugin
- flutter-plugins
- flutter-ui
- flutter-userinterfacce
- flutter-widget
- futtertoggle
- newflutter
- togglenewui
- toggleui
- userinterface

Developer notes

Code style
- Keep state minimal in parent widgets. Let Toggle2 hold internal animation state only.
- Prefer callbacks over direct state mutation. Use onChanged to update external stores.

Testing
- Widget tests: pumpWidget with Toggle2, tap or drag to trigger onChanged, expect new value.
- Integration: test on devices with different pixel ratios to validate blur performance.

Package publishing
- When publishing, increment version in pubspec.yaml and tag the release. Attach compiled example and docs.

Contributing

How to contribute
- Fork the repo.
- Create a branch: feature/your-feature-name.
- Add tests for new features.
- Send a pull request with a clear description and screenshots.

Issues
- Open issues for bugs, feature requests, or performance problems.
- Tag issues with labels: bug, enhancement, performance, docs.

Code of conduct
- Be respectful. Keep discussion technical.

Maintainers
- patrimpj and collaborators

License
- Included in repo. Check LICENSE file for full terms.

Contact
- Open an issue for questions or feature requests.

Assets & third-party
- Demo GIFs and images in this README reference public image hosts.
- Check individual asset sources for licensing if you use them in your app.