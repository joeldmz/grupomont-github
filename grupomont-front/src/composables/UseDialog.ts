import { ref, type Component } from 'vue'

export const dialogAberto = ref(false)
export const dialogTitulo = ref('')
export const dialogMensagem = ref('')
export const dialogComponentes = ref<Component[] | null>(null)
export const dialogProps = ref<Record<string, unknown>[]>([])

let acaoConfirmar: (() => void) | null = null

export function abrirDialog(
  titulo: string,
  mensagem: string,
  componentes: Component[] = [],
  props: Record<string, unknown> [] = [],
  onConfirm?: () => void
) {
  console.log('abrirDialog chamado')

  dialogTitulo.value = titulo
  dialogMensagem.value = mensagem
  dialogComponentes.value = componentes
  dialogProps.value = props
  acaoConfirmar = onConfirm ?? null

  dialogAberto.value = true

  console.log('dialogAberto:', dialogAberto.value)
}

export function fecharDialog() {
  dialogAberto.value = false
  dialogComponentes.value = []
  dialogProps.value = []
  acaoConfirmar = null
}

export function confirmarDialog() {
  acaoConfirmar?.()
  fecharDialog()
}