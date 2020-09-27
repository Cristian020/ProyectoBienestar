import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BeneficiarioTabsPage } from './beneficiario.page';

const routes: Routes = [
  {
    path: '',
    component: BeneficiarioTabsPage,
    children: [
      {
        path: 'invitaciones',
        loadChildren: () => import('../tab4/tab4.module').then(m => m.Tab4PageModule)
      },
      {
        path: 'reserva',
        loadChildren: () => import('../tab5/tab5.module').then(m => m.Tab5PageModule)
      },
      {
        path: 'disponibilidad',
        loadChildren: () => import('../tab6/tab6.module').then(m => m.Tab6PageModule)
      },
      {
        path: '',
        redirectTo: '/beneficiario/reserva',
        pathMatch: 'full'
      }

    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class BeneficiarioTabsPageRoutingModule {}
