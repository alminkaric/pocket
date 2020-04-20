import React from "react";

import {
  List,
  Datagrid,
  TextField,
  EmailField,
  DateField,
  ReferenceField,
  EditButton,
  SimpleForm,
  Edit,
  TextInput,
  ReferenceInput,
  SelectInput,
  Create,
  PasswordInput,
  Filter,
  SimpleList
} from "react-admin";
import useMediaQuery from '@material-ui/core/useMediaQuery';
import MyTextField from "./components/MyTextField";

const PersonFilter = (props) => (
  <Filter {...props}>
    <TextInput label="Search" source="q" alwaysOn />
    <ReferenceInput label="Client" source="clientId" reference="clients" allowEmpty>
      <SelectInput optionText="name" />
    </ReferenceInput>
  </Filter>
);

export const PersonList = (props: any) => {
  const isSmall = useMediaQuery((theme: any) => theme.breakpoints.down('sm'));
  return (
    <List filters={<PersonFilter />} {...props}>
      {isSmall ? (
        <SimpleList
          primaryText={record => `${record.firstName} ${record.lastName}`}
        />
      )
        : (
          <Datagrid rowClick="edit">
            <MyTextField source="id" />
            <ReferenceField source="clientId" reference="clients">
              <MyTextField source="name" />
            </ReferenceField>
            <TextField source="firstName" />
            <TextField source="lastName" />
            <EditButton />
          </Datagrid>
        )
      }
    </List>
  )
};

const PersonTitle = ({ record }) => {
  return <span>Editing {record ? `${record.firstName} ${record.lastName}` : ''}</span>;
};

export const PersonEdit = props => (
  <Edit title={<PersonTitle record={props.record} />} {...props}>
    <SimpleForm>
      <TextInput source="id" />
      <TextInput source="firstName" />
      <TextInput source="lastName" />
      <ReferenceInput source="clientId" reference="clients"><SelectInput optionText="name" /></ReferenceInput>
    </SimpleForm>
  </Edit>
);

export const PersonCreate = props => (
  <Create {...props}>
    <SimpleForm>
      <ReferenceInput source="clientId" reference="clients">
        <SelectInput optionText="name" />
      </ReferenceInput>
      <TextInput source="firstName" />
      <TextInput source="lastName" />
      <TextInput source="email" />
      <PasswordInput source="password" />
    </SimpleForm>
  </Create>
);