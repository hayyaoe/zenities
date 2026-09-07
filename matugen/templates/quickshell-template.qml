pragma Singleton
import QtQuick

QtObject {
    readonly property color background: "{{colors.background.default.hex}}"
    readonly property color surface: "{{colors.surface.default.hex}}"
    readonly property color surfaceContainer: "{{colors.surface_container.default.hex}}"
    readonly property color surfaceContainerHigh: "{{colors.surface_container_high.default.hex}}"

    readonly property color outline: "{{colors.outline.default.hex}}"
    readonly property color outlineVariant: "{{colors.outline_variant.default.hex}}"

    readonly property color on_surface: "{{colors.on_surface.default.hex}}"
    readonly property color on_surface_variant: "{{colors.on_surface_variant.default.hex}}"

    readonly property color primary: "{{colors.primary.default.hex}}"
    readonly property color on_primary: "{{colors.on_primary.default.hex}}"
    readonly property color primaryContainer: "{{colors.primary_container.default.hex}}"
    readonly property color on_primary_container: "{{colors.on_primary_container.default.hex}}"

    readonly property color secondary: "{{colors.secondary.default.hex}}"
    readonly property color on_secondary: "{{colors.on_secondary.default.hex}}"
    readonly property color tertiary: "{{colors.tertiary.default.hex}}"
    readonly property color on_tertiary: "{{colors.on_tertiary.default.hex}}"

    readonly property color error: "{{colors.error.default.hex}}"
    readonly property color on_error: "{{colors.on_error.default.hex}}"
    readonly property color errorContainer: "{{colors.error_container.default.hex}}"
    readonly property color on_error_container: "{{colors.on_error_container.default.hex}}"
}
