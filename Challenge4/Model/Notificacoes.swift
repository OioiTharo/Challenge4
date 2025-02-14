import Foundation
import UserNotifications

struct Lembrete {
    var titulo: String?
    var texto: String?
}

class Notificacoes: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    let diasSemana: Int = 1
    let notificationTime: Date = {
        var components = DateComponents()
        components.hour = 08
        components.minute = 00
        return Calendar.current.date(from: components) ?? Date()
    }()
    var lembreteAtividade = Lembrete(titulo: "Bom Dia Leitor! ☀️", texto: "Vamos dar uma atualizada no seu progresso?😉")
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    
    func permissaoNotificacao() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [self] granted, error in
            if let error = error {
                print("Erro ao solicitar permissão: \(error)")
            } else if granted {
                print("Permissão concedida!")
                self.agendarNotificacao(lembrete: lembreteAtividade, daysArray: diasSemana)
            } else {
                print("Permissão negada!")
            }
        }
    }
    
    func agendarNotificacao(lembrete: Lembrete, daysArray: Int) {
        let content = UNMutableNotificationContent()
        content.title = lembrete.titulo ?? "Booki"
        content.body = lembrete.texto ?? "Lembrete sem título"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.weekday = daysArray
        dateComponents.hour = Calendar.current.component(.hour, from: notificationTime)
        dateComponents.minute = Calendar.current.component(.minute, from: notificationTime)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao disparar notificação: \(error)")
            } else {
                print("Notificação agendada com sucesso!")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
