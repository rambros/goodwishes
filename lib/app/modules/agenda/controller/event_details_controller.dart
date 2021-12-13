import 'package:flutter_modular/flutter_modular.dart';
import '/app/shared/services/dialog_service.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsController {
  final _dialogService = Modular.get<DialogService>();


  void launchURL(int? eventDateId) async {
      var url = 'http://events.brahmakumaris.org/bkregistration/DemoFormGeneration.do?eventDateId=$eventDateId&templateName=english_bootstrap_form.ftl&resTemplateName=portuguese_desc_resp.ftl';
      if (await canLaunch(url)) {
        var dialogResponse = await _dialogService.showConfirmationDialog(
          title: 'Fazer inscrição no evento',
          description: 'Para informar os seus dados com segurança, conforme exige a Lei de Proteção de Dados, você será redirecionado para o site da Brahma Kumaris.\n\nPara retornar ao MeditaBK tecle o botão de voltar.',
          confirmationTitle: 'Continuar com inscrição',
          cancelTitle: 'Cancelar',
        );
        if (dialogResponse.confirmed!) {
            await launch(url,
                forceSafariVC: true,
                forceWebView: true,
                enableJavaScript: true,);
            };
      } else {
        throw 'Could not launch $url';
      }
  }

  Future<bool> launchLink(String url) async {
    return await launch(url,
                forceSafariVC: true,
                //forceWebView: true,
                enableJavaScript: true,);
  }

  


  
}