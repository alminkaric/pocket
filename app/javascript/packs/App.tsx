import React from 'react';
import { Admin, Resource, ListGuesser } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';
import { UserList } from "./users";
import { ClientList } from './clients';
import { PersonList } from './persons';

const dataProvider = jsonServerProvider('http://localhost:3000/api/v1');
const App = () => (
  <Admin dataProvider={dataProvider}>
    <Resource name="users" list={UserList} />
    <Resource name="clients" list={ClientList} />
    <Resource name="persons" list={PersonList} />
  </Admin>
);

export default App;