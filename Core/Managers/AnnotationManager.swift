import SwiftUI
import MapKit

struct AnnotationManager: View {
    @State private var newAnnotationTitle = ""
    @State private var annotations: [MapAnnotationItem] = []
    @StateObject private var wifiManager = WiFiLocationManager()
    
    @State private var mapPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334900, longitude: -122.009020),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    var body: some View {
        VStack {
            mapContent
            inputControls
            annotationList
        }
        .onAppear(perform: loadAnnotations)
    }

    private var mapContent: some View {
        Map(position: $mapPosition) {
            ForEach(annotations.indices, id: \.self) { index in
                Annotation(annotations[index].title, coordinate: annotations[index].coordinate) {
                    AnnotationView(item: annotations[index])
                }
                .tag(annotations[index])
            }
        }
        .mapStyle(.standard)
        .mapControls {
            MapCompass()
            MapScaleView()
            MapUserLocationButton()
        }
        .frame(height: 400)
    }

    private var inputControls: some View {
        HStack {
            TextField("Annotation Title", text: $newAnnotationTitle)
                .textFieldStyle(.roundedBorder)
            
            Button("Add") {
                addAnnotation()
            }
            .disabled(newAnnotationTitle.isEmpty)
        }
        .padding()
    }

    private var annotationList: some View {
        List(annotations) { annotation in
            Text("\(annotation.title): \(annotation.coordinate.latitude.formatted()), \(annotation.coordinate.longitude.formatted())")
        }
    }

    private func loadAnnotations() {
        annotations = AnnotationStorage.loadAnnotations()
        annotations.append(contentsOf: wifiManager.wifiAnnotations)
    }

    private func addAnnotation() {
        let centerCoordinate = mapPosition.region?.center ??
            CLLocationCoordinate2D(latitude: 37.334900, longitude: -122.009020)

        let newAnnotation = MapAnnotationItem(
            title: newAnnotationTitle,
            coordinate: centerCoordinate,
            kind: .userPin
        )
        annotations.append(newAnnotation)
        newAnnotationTitle = ""
        AnnotationStorage.saveAnnotations(annotations)
    }
}

struct AnnotationView: View {
    let item: MapAnnotationItem
    
    var body: some View {
        VStack {
            Image(systemName: item.kind == .userPin ? "mappin.circle.fill" : "wifi.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(item.kind == .userPin ? .red : .blue)
            Text(item.title)
                .font(.caption)
        }
    }
}

// Modified extension to fix protocol conformance issues
extension MapAnnotationItem: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Remove the Identifiable extension as it's redundant
// The id property should be defined in the main struct instead
