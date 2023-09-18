module window

import system

#include <SFML/Window/Sensor.h>

// SensorType: sensor Types
pub enum SensorType {
	accelerometer // Measures the raw acceleration (m/s^2)
	gyroscope // Measures the raw rotation rates (degrees/s)
	magnetometer // Measures the ambient magnetic field (micro-teslas)
	gravity // Measures the direction and intensity of gravity, independent of device acceleration (m/s^2)
	user_acceleration // Measures the direction and intensity of device acceleration, independent of the gravity (m/s^2)
	orientation // Measures the absolute 3D orientation (degrees)
}

fn C.sfSensor_isAvailable(C.sfSensorType) int
fn C.sfSensor_setEnabled(C.sfSensorType, int)
fn C.sfSensor_getValue(C.sfSensorType) C.sfVector3f

// sensor_is_available: check if a sensor is available on the underlying platform
pub fn sensor_is_available(sensor SensorType) bool {
	unsafe {
		return C.sfSensor_isAvailable(*&C.sfSensorType(&sensor)) != 0
	}
}

// sensor_set_enabled: enable or disable a sensor
// All sensors are disabled by default, to avoid consuming too
// much battery power. Once a sensor is enabled, it starts
// sending events of the corresponding type.
// This function does nothing if the sensor is unavailable.
pub fn sensor_set_enabled(sensor SensorType, enabled bool) {
	unsafe {
		C.sfSensor_setEnabled(*&C.sfSensorType(&sensor), int(enabled))
	}
}

// sensor_get_value: get the current sensor value
pub fn sensor_get_value(sensor SensorType) system.Vector3f {
	unsafe {
		return system.Vector3f(C.sfSensor_getValue(*&C.sfSensorType(&sensor)))
	}
}
