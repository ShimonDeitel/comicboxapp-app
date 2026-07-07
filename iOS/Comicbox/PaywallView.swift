import SwiftUI
import StoreKit

struct PaywallView: View {
    @EnvironmentObject var purchases: PurchaseManager
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(Theme.accent)
                Text("Comicbox Pro")
                    .font(Theme.titleFont)
                    .foregroundColor(Theme.textPrimary)
                Text("Run-completion tracker across a series")
                    .font(Theme.bodyFont)
                    .foregroundColor(Theme.textMuted)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                if let product = purchases.products.first {
                    Button {
                        Task {
                            await purchases.purchasePro()
                            if purchases.isPro { dismiss() }
                        }
                    } label: {
                        Text("Subscribe \(product.displayPrice)/month")
                            .font(Theme.headlineFont)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.accent)
                            .foregroundColor(.white)
                            .cornerRadius(Theme.cornerRadius)
                    }
                    .padding(.horizontal)
                    .accessibilityIdentifier("subscribeButton")
                } else {
                    ProgressView()
                }
                Button("Restore Purchases") {
                    Task { await purchases.restore() }
                }
                .accessibilityIdentifier("paywallRestoreButton")
                Spacer()
            }
            .padding(.top, 40)
            .background(Theme.background.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .accessibilityIdentifier("paywallCloseButton")
                }
            }
        }
    }
}
