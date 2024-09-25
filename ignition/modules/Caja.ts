
import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CajaCoinModule = buildModule("CajaCoinModule", (m) => {
  const caja = m.contract("Caja")
  return { caja }
})

export default CajaCoinModule